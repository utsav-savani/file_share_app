import 'package:file_sharing_appp/Constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButtonDesign extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color backGroundColor;
  final Color textColor;
  final double horizontalPadding;

  const CustomButtonDesign(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.backGroundColor,
      this.textColor,
      this.horizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 10.0,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backGroundColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55.0),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: CustomTextPurpleBold(
        text: "$text",
        color: textColor,
        size: size,
      ),
    );
  }
}

class CustomTextPurpleBold extends StatelessWidget {
  final String text;
  final Size size;
  final Color color;

  const CustomTextPurpleBold({Key key, this.text, this.size, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          color: color,
          fontSize: size.width * 0.06,
          fontFamily: "Georgia_bold",
          letterSpacing: 2.0),
    );
  }
}


class CustomTextPurpleBoldSize extends StatelessWidget {
  final String text;
  final Size size;
  final Color color;

  const CustomTextPurpleBoldSize({Key key, this.text, this.size, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          color: color,
          fontSize: size.width * 0.045,
          fontFamily: "Georgia_bold",
          letterSpacing: 2.0),
    );
  }
}


class CustomTextReg extends StatelessWidget {
  final String text;
  final Size size;
  final Color color;
  const CustomTextReg({Key key, this.text, this.size, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          color: color,
          fontSize: size.width * 0.06,
          fontFamily: "Georgia_reg",
          letterSpacing: 2.0),
    );
  }
}


class CustomTextRegSize extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  const CustomTextRegSize({Key key, this.text, this.size, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: "Georgia_reg",
          letterSpacing: 2.0),
    );
  }
}
