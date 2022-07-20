import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konnect_app/pages/retailers_list_page.dart';
import 'package:konnect_app/prefs/prefs.dart';
import 'package:konnect_app/widgets/common_widgets.dart';

import '../constants/Colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOtp = false;
  String? mobileNumber;
  String? otp;
  final TextEditingController _mobileNumberController =
      TextEditingController(text: '');
  final TextEditingController _otpController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: Get.height * .4,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      textWidget(
                          text: 'ChannelKonnect',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        textWidget(
                            text: 'Login',
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        const SizedBox(
                          height: 20,
                        ),
                        !isOtp
                            ? TextField(
                                controller: _mobileNumberController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                onChanged: (s) {
                                  mobileNumber = s;
                                },
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Mobile Number',
                                  prefix: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: textWidget(
                                        text: '+91',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : TextField(
                                controller: _otpController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                onChanged: (s) {
                                  otp = s;
                                },
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Enter OTP',
                                ),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        !isOtp
                            ? cartButton(
                                onTap: () {
                                  if (mobileNumber!.isNotEmpty &&
                                      mobileNumber!.length == 10) {
                                    isOtp = true;

                                    setState(() {});
                                  } else {
                                    Get.snackbar('Enter correct Number',
                                        'Check Number You have Entered');
                                  }
                                },
                                text: 'Send OTP')
                            : cartButton(
                                onTap: () {
                                  if (otp!.isNotEmpty && otp!.length == 4) {
                                    PrefsDb.saveLogin(true);
                                    Get.to(const RetailerListPage());
                                    setState(() {});
                                  } else {
                                    Get.snackbar('Enter correct Otp',
                                        'Enter 4 digit Otp');
                                  }
                                },
                                text: 'Login')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
