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

class FileManager extends StatelessWidget {
  final _smsController = new TextEditingController();
  List<String> filesList = [
    "Audio",
    "Video",
    "Photos",
    "Document",
    "APK",
    "Messanger",
    "Whatsapp",

  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        child:  Column(
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

            Container(


              child:
                 ListView.builder(
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                   return CustomListView(
                     text: filesList[index],
                     size: size,
                   );
                 },)

            ),
          ],
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final Size size;
  final String text;
  final String imgPath;
  const CustomListView({Key key, this.size, this.text, this.imgPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.audiotrack),
        CustomTextPurpleBold(text:"$text",size: size,),
        Spacer(),
        Text("200 items")
      ],
    );
  }
}

