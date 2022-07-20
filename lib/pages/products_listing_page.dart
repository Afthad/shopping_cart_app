import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:konnect_app/controller/order_controller.dart';
import 'package:konnect_app/models/cart.dart';
import 'package:konnect_app/models/products.dart';
import 'package:konnect_app/pages/cart_screen.dart';

import '../constants/Colors.dart';
import '../widgets/common_widgets.dart';

class ProductsListingPage extends StatefulWidget {
  const ProductsListingPage({Key? key}) : super(key: key);

  @override
  State<ProductsListingPage> createState() => _ProductsListingPageState();
}

class _ProductsListingPageState extends State<ProductsListingPage> {
  final OrderController controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => !controller.isLoading.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: 'Products',
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          GestureDetector(
                            onTap: () {
                              Get.to(const CartScreen());
                            },
                            child: Badge(
                              badgeContent:
                                  textWidget(text: '${controller.cartCount}'),
                              badgeColor: AppColors.primaryColor,
                              child: const Icon(Icons.shopping_cart),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: controller.products
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: productTile(e),
                                      ))
                                  .toList()),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget productTile(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              product.prodImage,
              cacheHeight: 200,
              width: Get.width,
              errorBuilder: (c, o, s) {
                return SizedBox(
                  height: 200,
                  width: Get.width,
                  child: const Icon(Icons.error),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            textWidget(
                text: product.prodName,
                color: Colors.orange,
                fontWeight: FontWeight.bold),
            const SizedBox(
              height: 10,
            ),
            textWidget(
                text: "₹ ${product.prodMrp}", fontWeight: FontWeight.bold),
            const SizedBox(
              height: 10,
            ),
            textWidget(text: 'Product code : ${product.prodCode}'),
            const SizedBox(
              height: 10,
            ),
            cartButton(
                onTap: () {
                  controller
                      .addToCart(Cart(productId: product.prodId, count: 1));
                  controller.getCartCount();
                },
                text: 'Add to cart')
          ],
        ),
      ),
    );
  }
}
