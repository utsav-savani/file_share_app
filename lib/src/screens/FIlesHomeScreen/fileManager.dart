import 'dart:async';


import 'package:file_sharing_appp/Constants/constants.dart';
import 'package:file_sharing_appp/provider/phone_auth_provider.dart';
import 'package:file_sharing_appp/src/Widgets/custom_button_design.dart';
import 'package:file_sharing_appp/src/screens/AddPhone/add_phone.dart';
import 'package:file_sharing_appp/src/screens/Whatsapp/whatsapp.dart';
import 'package:file_sharing_appp/src/screens/apkScreen/apk_screen.dart';
import 'package:file_sharing_appp/src/screens/audioFiles/audioFiles.dart';
import 'package:file_sharing_appp/src/screens/documents/documents.dart';
import 'package:file_sharing_appp/src/screens/messanger/messanger.dart';
import 'package:file_sharing_appp/src/screens/photos/photos.dart';
import 'package:file_sharing_appp/src/screens/profileScreen/profile_screen.dart';
import 'package:file_sharing_appp/src/screens/videoFiles/videoFiles.dart';
import 'package:flutter/services.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class FileManager extends StatefulWidget {
  @override
  _FileManagerState createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  final _smsController = new TextEditingController();
  List<StorageInfo> _storageInfo = [];

  double _diskSpaceFree = 0;
  double _diskSpaceTotal = 0;





  List<String> filesList = [
    "Audio",
    "Video",
    "Photos",
    "Document",
    "APK",
    "Messanger",
    "Whatsapp",

  ];

  List<String> imageList = [
    "assets/icons/audio.svg",
    "assets/icons/video.svg",
    "assets/icons/photos.svg",
    "assets/icons/documents.svg",
    "assets/icons/apps_icon.svg",
    "assets/icons/messanger_icon.svg",
    "assets/icons/whatsapp_icon.svg",

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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.1,
              child: Row(
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                    },
                    child: SvgPicture.asset(
                      "assets/icons/user_home_icon.svg",
                      height: 25,
                    ),
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
height: size.height*0.8,

              child:
                 ListView.builder(
                   shrinkWrap: true,
                   itemCount: 1,
                   itemBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       children: [
                       CustomListView(
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => MyAudioList(),));
                         },
                        imgPath: "assets/icons/audio.svg",
                       text: "Audio",
                       size: size,
                     ),
                       Divider(
                         height: 5.0,
                         color: Colors.black.withOpacity(0.3),
                       ),
                       CustomListView(
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => MyVideosList(),));
                         },
                         imgPath: "assets/icons/video .svg",
                       text: "Video",
                       size: size,
                       ),
                         Divider(
                           height: 5.0,
                           color: Colors.black.withOpacity(0.3),
                         ),
                         CustomListView(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhotosList(),));
                           },
                           imgPath: "assets/icons/photos.svg",
                           text: "Photos",
                           size: size,
                         ),
                         Divider(
                           height: 5.0,
                           color: Colors.black.withOpacity(0.3),
                         ),
                         CustomListView(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyDocsList(),));
                           },
                           imgPath: "assets/icons/documents.svg",
                           text: "Documents",
                           size: size,
                         ),
                         Divider(
                           height: 5.0,
                           color: Colors.black.withOpacity(0.3),
                         ),
                         CustomListView(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyApkList(),));
                           },
                           imgPath: "assets/icons/apps_icon.svg",
                           text: "Apk",
                           size: size,
                         ),
                         Divider(
                           height: 5.0,
                           color: Colors.black.withOpacity(0.3),
                         ),
                         CustomListView(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyMessangerList(),));
                           },
                           imgPath: "assets/icons/messanger_icon.svg",
                           text: "Messanger",
                           size: size,
                         ),
                         Divider(
                           height: 5.0,
                           color: Colors.black.withOpacity(0.3),
                         ),
                         CustomListView(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyWhatsappList(),));
                           },
                           imgPath: "assets/icons/whatsapp_icon.svg",
                           text: "Whatsapp",
                           size: size,
                         ),
                         Divider(
                           height: 5.0,
                           color: Colors.black.withOpacity(0.3),
                         ),
                         SizedBox(
                           height: 10.0,
                         ),
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 15,
//                             ),
//                             CustomTextPurpleBoldSize(text:"SD Card",size: size,),
//                             Spacer(),
//                             Text(
//                                 '$_diskSpaceTotal - $_diskSpaceFree used'),
//
//                           ],
//                         ),
//                         LinearProgressIndicator(
//                           backgroundColor: kSplashScreenBackColor,
//                           value: 80,
//                         ),
                       ],
                     ),
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
  final Function onPressed;
  final Size size;
  final String text;
  final String imgPath;
  const CustomListView({Key key, this.size, this.text, this.imgPath, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "$imgPath",
              height: 35,
            ),
            SizedBox(
              width: 35,
            ),
            CustomTextPurpleBoldSize(text:"$text",size: size,),


          ],
        ),
      ),
    );
  }
}

