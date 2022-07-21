import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:konnect_app/controller/database_controller.dart';
import 'package:konnect_app/models/cart.dart';
import 'package:konnect_app/models/products.dart';

class OrderController extends GetxController {
  late Response response;
  var dio = Dio();

  @override
  void onInit() {
    getInitialData();

    super.onInit();
  }

  RxBool isLoading = true.obs;
  RxList<Product> products = <Product>[].obs;
  getInitialData() async {
    var res = await DatabaseManager().database;
    if (res.isOpen) {
      getFromDB();
    }
  }

  storeToLocalDB(List<Product> products) async {
    int isSuccess = 0;
    for (var e in products) {
      isSuccess = await DatabaseManager().addProducts(e);
    }
    if (isSuccess != 0) {
      getFromDB();
    }
  }

  getFromDB() async {
    var res = await DatabaseManager().getAllProducts();
    if (res.isEmpty) {
      getProductsFromServer();
    } else {
      for (var e in res) {
        products.add(Product.fromJson(e));
      }
      isLoading.value = false;
    }
  }

  getProductsFromServer() async {
    response = await dio.get('https://jsonkeeper.com/b/YIDG');
    if (response.statusCode == 200) {
      storeToLocalDB(Data.fromJson(response.data['data']).products);
    }
  }

  /// Cart

  RxList<Cart> cartItems = <Cart>[].obs;

  addToCart(Cart cart) {
    bool isExists = false;
    for (var e in cartItems) {
      if (e.productId == cart.productId) {
        e.count = e.count + 1;
        isExists = true;

        break;
      }
    }
    if (!isExists) {
      cartItems.add(cart);
    }
  }

  addCount(int id) {
    for (var e in cartItems) {
      if (e.productId == id) {
        e.count = e.count + 1;
        break;
      }
    }
    isProductExistInCart(id);
  }

  reduceCount(int id) {
    for (var e in cartItems) {
      if (e.productId == id && e.count > 1) {
        e.count = e.count - 1;
        break;
      }
      if (e.productId == id && e.count == 1) {
        deleteCartItem(id);
        break;
      }
    }
    isProductExistInCart(id);
  }

  deleteCartItem(int id) {
    cartItems.removeWhere((element) => element.productId == id);
    isProductExistInCart(id);
  }

  RxInt cartCount = 0.obs;
  void getCartCount() {
    cartCount.value = cartItems.fold<int>(
        0, (previousValue, element) => element.count + previousValue);
    getTotalPrice();
  }

  RxDouble totalPrice = 0.0.obs;
  void getTotalPrice() {
    totalPrice.value = cartItems.fold<double>(
        0,
        (previousValue, element) =>
            (double.parse((element.price.toString())) * element.count) +
            previousValue);
  }

  RxBool isExists = false.obs;
  isProductExistInCart(
    int prodId,
  ) {
    for (var e in cartItems) {
      if (e.productId == prodId) {
        isExists.value = true;
        break;
      } else {
        isExists.value = false;
      }
    }
  }
}
