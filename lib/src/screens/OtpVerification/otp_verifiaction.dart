import 'dart:async';

import 'package:file_sharing_appp/Constants/constants.dart';
import 'package:file_sharing_appp/provider/phone_auth_provider.dart';
import 'package:file_sharing_appp/src/Widgets/custom_button_design.dart';
import 'package:file_sharing_appp/src/screens/AddPhone/add_phone.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class OtpVerification extends StatelessWidget {
  final _smsController = new TextEditingController();

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
                      "assets/icons/OtpVerificationScreen/otp_veri.svg",
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
                          text: "Enter Code Sent",
                          color: kSplashScreenBackColor,
                        ),
                        CustomTextPurpleBold(
                          size: size,
                          text: "To Your Phone",
                          color: kSplashScreenBackColor,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextReg(
                          color: Colors.grey,
                          size: size * 0.7,
                          text: "We send to the number 80000",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Consumer<PhoneAuthProviderData>(
                          builder: (context, value, child) {
                            return TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              controller: _smsController,
                              onChanged: (sms) {
                                value.smsCl = sms;
                              },
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: kSplashScreenBackColor,
                                  fontFamily: "Georgia_bold",
                                  letterSpacing: 2.0),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.call,
                                  color: Colors.grey,
                                ),
                                focusColor: kSplashScreenBackColor,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: kSplashScreenBackColor,
                                )),
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
                ],
              ),
            ),
            Positioned(
              bottom: size.height * 0.05,
              child: Builder(
                builder: (ctx) {
                  return CustomButtonDesign(
                    horizontalPadding: 80.0,
                    backGroundColor: kSplashScreenBackColor,
                    textColor: kWhiteColor,
                    text: "Verify",
                    onPressed: () {
                      var call = context.read<PhoneAuthProviderData>();

                      if (call.smsCode == "") {
                        print("Error");
                      } else {
                        call.signInWithPhoneNumber(ctx).then((value) {
                          if(value == "error")
                            {
                              Toast.show("Error validation otp please try again", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                            }
                          else
                            {
                              print(value);
                            }
                        });
                        Timer(Duration(seconds: 5), () {
                          Navigator.pushNamed(context, "/homePage");
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
