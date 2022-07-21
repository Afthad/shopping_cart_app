import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konnect_app/controller/order_controller.dart';
import 'package:konnect_app/models/products.dart';
import 'package:konnect_app/pages/checked_in_screen.dart';
import 'package:konnect_app/prefs/prefs.dart';
import 'package:konnect_app/widgets/common_widgets.dart';

import '../constants/Colors.dart';
import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final OrderController controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  textWidget(
                      text: 'Cart', fontSize: 30, fontWeight: FontWeight.bold),
                  controller.cartItems.isNotEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: controller.cartItems
                                    .map((e) => cartItems(
                                        controller.products
                                            .where((p0) =>
                                                p0.prodId == e.productId)
                                            .first,
                                        e))
                                    .toList()),
                          ),
                        )
                      : Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 200,
                              ),
                              const Icon(
                                Icons.shopping_cart_outlined,
                                size: 100,
                              ),
                              textWidget(
                                  text: 'No Products in Cart',
                                  fontSize: 16,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: controller.cartCount > 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: 'Total',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          textWidget(
                              text: '₹ ${controller.totalPrice.toString()}',
                              fontSize: 15,
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      cartButton(
                          onTap: () {
                            PrefsDb.checkOut('Order-taken');
                            Get.snackbar('Order placed successfully', '');

                            Get.bottomSheet(
                                WillPopScope(
                                  onWillPop: () => Future.value(false),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          textWidget(
                                            text: 'Order Placed Successfully',
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          cartButton(
                                              text: 'Go to CheckIn Screen',
                                              onTap: () {
                                                Get.offAll(
                                                    const CheckedInPage());
                                              })
                                        ]),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                enableDrag: false,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))));
                          },
                          text: 'Place Order'),
                    ],
                  )
                : null,
          ),
        ));
  }

  Widget cartItems(Product product, Cart cart) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(
                  child: Image.network(
                    product.prodImage,
                    cacheHeight: 40,
                    height: 100,
                    width: 100,
                    errorBuilder: (c, o, s) {
                      return const SizedBox(
                        height: 100,
                        width: 100,
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: product.prodName,
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    textWidget(
                        text:
                            '₹ ${(double.parse(product.prodMrp.toString()) * cart.count)}',
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.reduceCount(cart.productId);
                            controller.getCartCount();
                          },
                          child: const Icon(Icons.remove_circle_rounded,
                              color: AppColors.primaryColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        textWidget(text: cart.count.toString()),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.addCount(cart.productId);
                            controller.getCartCount();
                          },
                          child: const Icon(
                            Icons.add_circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
