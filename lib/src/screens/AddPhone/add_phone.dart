import 'dart:async';

import 'package:file_sharing_appp/Constants/constants.dart';
import 'package:file_sharing_appp/provider/phone_auth_provider.dart';
import 'package:file_sharing_appp/src/Widgets/custom_button_design.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddPhone extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: size.height * 0.2,
                width: size.width,
                color: kHomeContainerColor,
              ),
            ),
            Positioned(
              top: size.height * 0.12,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: SvgPicture.asset(
                      "assets/icons/AddphoneScreen/mobile_num.svg",
                      height: 200,
                    ),
                  ),
                  Container(
                    width: size.width * 0.9,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextPurpleBold(
                          size: size,
                          text: "Enter your",
                          color: kSplashScreenBackColor,
                        ),
                        CustomTextPurpleBold(
                          size: size,
                          text: "Mobile Number",
                          color: kSplashScreenBackColor,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextReg(
                          color: Colors.grey,
                          size: size * 0.7,
                          text: "We will send you verification code",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Consumer<PhoneAuthProviderData>(
                          builder: (context, value, child) {
                            return TextField(
                              // keyboardType: TextInputType.numberWithOptions(
                              //     decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.+,]')),
                              ],
                              onChanged: (phone) {
                                value.phoneClear = phone;
                              },
                              controller: _phoneNumberController,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: kSplashScreenBackColor,
                                  fontFamily: "Georgia_bold",
                                  letterSpacing: 2.0),
                              decoration: InputDecoration(
                                labelText: "Enter with Country Code",
                                labelStyle:
                                    TextStyle(color: kSplashScreenBackColor),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: value.phoneNumber.value != ""
                                      ? kSplashScreenBackColor
                                      : Colors.red,
                                )),
                                errorText: value.phoneNumber.value != ""
                                    ? ""
                                    : value.phoneErrorText,
                                prefixIcon: Icon(
                                  Icons.call,
                                  color: Colors.grey,
                                ),
                                focusColor: kSplashScreenBackColor,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: value.phoneNumber.value != ""
                                        ? kSplashScreenBackColor
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
//
                ],
              ),
            ),
            Positioned(
                bottom: size.height * 0.05,
                child: Builder(
                  builder: (ctx) {
                    return CustomButtonDesign(
                      horizontalPadding: 60.0,
                      backGroundColor: kSplashScreenBackColor,
                      textColor: kWhiteColor,
                      text: "Continue",
                      onPressed: () async {
                        var call = context.read<PhoneAuthProviderData>();

                        if (call.phoneNumber == null ||
                            call.phoneNumber.value == "") {
                          print("Enter Number");
                        } else {
                          var data;
                          data = await call.verifyPhoneNumber(ctx).then((val) {
                            print("val :: $val");

                              Toast.show("Error Please check number", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);

                            //data = val;

                              Navigator.pushNamed(context, "/optVerification");

                          });

                          print(call.phoneNumber.value);
                          print("da is ${call.verificationIdBse}");
                        }
                      },
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
