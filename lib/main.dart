import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, "assets/icons/SplashScreen/splashl.svg"),
      null);
  await Firebase.initializeApp();
  runApp(MyApp());
}
