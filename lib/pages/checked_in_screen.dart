import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konnect_app/pages/products_listing_page.dart';
import 'package:konnect_app/pages/retailers_list_page.dart';
import 'package:konnect_app/prefs/prefs.dart';
import 'package:konnect_app/widgets/common_widgets.dart';

import '../constants/Colors.dart';

class CheckedInPage extends StatelessWidget {
  const CheckedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
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
                    text: 'Activities',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 50),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const ProductsListingPage());
                      },
                      child: options(
                          icon: const Icon(
                            Icons.add,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                          title: 'Take Order'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(const NoOrderBottomSheet(),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))));
                      },
                      child: options(
                          icon: const Icon(
                            Icons.remove_circle_outline_sharp,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                          title: 'No order'),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (PrefsDb.getcheckOut != null) {
                          PrefsDb.checkOut(null);
                          Get.offAll(const RetailerListPage());
                        } else {
                          Get.snackbar('You cant check out',
                              'You cant check out unitl you place order or punch no order');
                        }
                      },
                      child: options(
                          icon: const Icon(
                            Icons.close,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                          title: 'CheckOut'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget options({required Icon icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.orange,
        elevation: 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              textWidget(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }
}

class NoOrderBottomSheet extends StatefulWidget {
  const NoOrderBottomSheet({Key? key}) : super(key: key);

  @override
  State<NoOrderBottomSheet> createState() => _NoOrderBottomSheetState();
}

class _NoOrderBottomSheetState extends State<NoOrderBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String? remarks;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
                text: 'Remarks', fontSize: 20, fontWeight: FontWeight.bold),
            TextFormField(
              onChanged: (s) {
                remarks = s;
              },
              validator: (s) {
                if (s!.isEmpty) {
                  return "Remarks can't be empty";
                }
                if (s.length < 3) {
                  return "Remarks can't be less than 3 characters";
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            cartButton(
                text: 'Submit',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    PrefsDb.checkOut('No Order');
                    Get.back();
                  }
                })
          ],
        ),
      ),
    );
  }
}
