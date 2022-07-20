import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konnect_app/constants/Colors.dart';
import 'package:konnect_app/models/retailer.dart';
import 'package:konnect_app/pages/checked_in_screen.dart';
import 'package:konnect_app/pages/login_screen.dart';
import 'package:konnect_app/prefs/prefs.dart';
import 'package:konnect_app/widgets/common_widgets.dart';

class RetailerListPage extends StatefulWidget {
  const RetailerListPage({Key? key}) : super(key: key);

  @override
  State<RetailerListPage> createState() => _RetailerListPageState();
}

class _RetailerListPageState extends State<RetailerListPage> {
  @override
  void initState() {
    getRetailers();
    super.initState();
  }

  bool isLoading = true;
  getRetailers() {
    retailerList = RetailerList.fromMap(retailers);
    isLoading = false;
  }

  RetailerList? retailerList;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: !isLoading
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
                              text: 'Retailers',
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          IconButton(
                              onPressed: () {
                                PrefsDb.saveLogin(false);
                                Get.offAll(const LoginScreen());
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: AppColors.primaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: retailerList!.retailers
                                  .map((e) => retailerTile(retailer: e))
                                  .toList()),
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  Widget retailerTile({required Retailer retailer}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  textWidget(
                      text: retailer.retailerName.toUpperCase(),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    retailer.shopImage,
                    height: 130,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (retailer
                            .toMap()
                            .entries
                            .where((element) => element.key != 'shopImage')
                            .map((e) => Row(
                                  children: [
                                    textWidget(
                                        fontSize: 12,
                                        text: '${e.key.toUpperCase()} : ',
                                        fontWeight: FontWeight.w600),
                                    textWidget(
                                        text: e.value, color: Colors.orange),
                                  ],
                                ))
                            .toList()),
                      ),
                      cartButton(
                          height: 30,
                          width: 50,
                          onTap: () {
                            PrefsDb.saveCheckIn(retailer.retailerName);
                            Get.to(const CheckedInPage());
                          },
                          text: 'Check IN'),
                    ],
                  )
                ]),
          ),
        ));
  }
}

Map retailers = {
  'retailers': [
    {
      'retailerName': 'Vestar retail',
      'ownerName': 'Laxmi mittal',
      'address': 'S.N Nagar',
      'city': 'Banglore',
      'mobileNumber': '92070233333',
      'shopImage':
          'https://eazyfin.s3.ap-south-1.amazonaws.com/public-doc/2674bc10-feab-11ec-898a-37a4b12d2093-Family_illustration.png',
      'state': 'Karnataka',
    },
    {
      'retailerName': 'Voltas brand store',
      'ownerName': 'SN Swami',
      'address': 'M.G.Nagar',
      'city': 'Banglore',
      'mobileNumber': '9207023343',
      'shopImage':
          'https://eazyfin.s3.ap-south-1.amazonaws.com/public-doc/2674bc10-feab-11ec-898a-37a4b12d2093-Family_illustration.png',
      'state': 'Karnataka',
    },
    {
      'retailerName': 'Samsung',
      'ownerName': 'koshi',
      'address': 'S.N Nagar',
      'city': 'Banglore',
      'mobileNumber': '9207023033',
      'shopImage':
          'https://eazyfin.s3.ap-south-1.amazonaws.com/public-doc/2674bc10-feab-11ec-898a-37a4b12d2093-Family_illustration.png',
      'state': 'Karnataka',
    }
  ]
};
