import 'package:file_sharing_appp/Constants/constants.dart';
import 'package:file_sharing_appp/src/Widgets/custom_button_design.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: kSplashScreenBackColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/SplashScreen/splashl.svg",
                  height: size.width * 0.7,
                ),
                Text(
                  "File Sharing Manager",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: size.width * 0.06,
                      fontFamily: "Georgia_reg",
                      letterSpacing: 2.0),
                ),
              ],
            ),
            Positioned(
              bottom: size.height * 0.05,
              child: CustomButtonDesign(
                horizontalPadding: 40.0,
                backGroundColor: kWhiteColor,
                textColor: kSplashScreenBackColor,
                text: "Get Started",
                onPressed: () => Navigator.pushNamed(context, "/addPhone"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
