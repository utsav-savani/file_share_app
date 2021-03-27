import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'src/my_app.dart';
MethodChannel channel = new MethodChannel("federated_login");

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, "assets/icons/SplashScreen/splashl.svg"),
      null);
  await Firebase.initializeApp();
  runApp(MyApp());
}
