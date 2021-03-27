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

class ProfileScreen extends StatelessWidget {
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
                color: kSplashScreenBackColor,
              ),
            ),
            Positioned(
              top: size.height * 0.12,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: SvgPicture.asset(
                      "assets/icons/profile change icon.svg",
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
                          text: "Profile",
                          color: kHomeContainerColor,
                        ),

                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextReg(
                          color: Colors.grey,
                          size: size * 0.7,
                          text: "Enter your name here",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                    TextField(
                      // keyboardType: TextInputType.numberWithOptions(
                      //     decimal: true),


                      controller: _phoneNumberController,
                      cursorColor: Colors.grey,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: kSplashScreenBackColor,
                          fontFamily: "Georgia_bold",
                          letterSpacing: 2.0),
                      decoration: InputDecoration(


                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kHomeContainerColor,
                            )),

                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                        ),
                        focusColor: kSplashScreenBackColor,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: kHomeContainerColor,
                          ),
                        ),
                      ),
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
                      horizontalPadding: 100.0,
                      backGroundColor: kHomeContainerColor,
                      textColor: kWhiteColor,
                      text: "Save",
                      onPressed: () async {

                            //data = val;

                            Navigator.pop(context);


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
