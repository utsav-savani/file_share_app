import 'package:file_sharing_appp/src/screens/AddPhone/add_phone.dart';
import 'package:file_sharing_appp/src/screens/FIlesHomeScreen/fileManager.dart';
import 'package:file_sharing_appp/src/screens/HomePage/home_page.dart';
import 'package:file_sharing_appp/src/screens/OtpVerification/otp_verifiaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_sharing_appp/provider/phone_auth_provider.dart';
import 'screens/SplashScreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhoneAuthProviderData(),
      child: MaterialApp(
        title: "File Sharing Manager",
        initialRoute: "/",
        routes: {
          "/": (context) => FileManager(),
          "/addPhone": (context) => AddPhone(),
          "/optVerification": (context) => OtpVerification(),
          "/homePage": (context) => HomePage(),
        },
      ),
    );
  }
}
