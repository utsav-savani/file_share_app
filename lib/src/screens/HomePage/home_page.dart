import 'package:file_sharing_appp/Constants/constants.dart';
import 'package:file_sharing_appp/src/Widgets/custom_button_design.dart';
import 'package:file_sharing_appp/src/screens/FIlesHomeScreen/fileManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/user_home_icon.svg",
                      height: 25,
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      "assets/icons/history.svg",
                      height: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      "assets/icons/notification.svg",
                      height: 25,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.12,
              ),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.35,
                child:
                    SvgPicture.asset("assets/icons/HomeScreen/home_screen.svg"),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                width: size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextPurpleBold(
                      text: "You Can Share",
                      size: size,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextPurpleBold(
                      text: "All Types Files Here",
                      size: size,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5.0,
                      child: CustomButtonDesign(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => FileManager(),
                          ));
                        },
                        horizontalPadding: 60.0,
                        text: "Share Files",
                        backGroundColor: kSplashScreenBackColor,
                        textColor: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
