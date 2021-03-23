import 'package:file_sharing_appp/Validators/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthProviderData extends ChangeNotifier {
  String verificationIdBse;
  ValidationItem _phoneNumber = ValidationItem(null, null);
  FirebaseAuth authId = FirebaseAuth.instance;
  //String _phoneNumber;
  String _smsCode = "";
  String phoneErrorText = "Enter valid number";
  bool isSentCodeDone = false;

  bool getIsSentCode() => isSentCodeDone;

  void setIsSendCode(value) {
    isSentCodeDone = value;
    notifyListeners();
  }

  String get verification => verificationIdBse;
  String get smsCode => _smsCode;
  get auth => authId;

  set smsCl(val) {
    _smsCode = val;
    notifyListeners();
  }

  ValidationItem get phoneNumber => _phoneNumber;

  void phoneNumberValidator(String value) {
    if (value.length == 0) {
      _phoneNumber = ValidationItem(null, "Number must not ne empty");
    } else if (value.length != 10) {
      _phoneNumber = ValidationItem(null, "Number must be of 10 digits only");
    } else {
      _phoneNumber = ValidationItem(value, null);
    }
    notifyListeners();
  }

  set phoneClear(val) {
    _phoneNumber = ValidationItem(val, null);
    notifyListeners();
  }

  Future<String> verifyPhoneNumber(BuildContext ctx) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await auth.signInWithCredential(phoneAuthCredential);
      showSnackbar(
          "Phone number automatically verified and user signed in: ${auth.currentUser.uid}",
          ctx);
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
          ctx);
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar("Please check your messages for verification Code", ctx);
      verificationIdBse = verificationId;
      print("data + $verificationIdBse");
      notifyListeners();
      return "next";
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId, ctx);
      verificationIdBse = verificationId;
      print("data + $verificationIdBse");
      notifyListeners();
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber.value,
          timeout: const Duration(seconds: 10),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

      notifyListeners();
      return verificationIdBse;
    } catch (e) {
      showSnackbar("error $e", ctx);
      notifyListeners();
      return "error";
    }
  }

  Future<String> signInWithPhoneNumber(BuildContext ctx) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdBse,
        smsCode: smsCode,
      );

      final User user = (await auth.signInWithCredential(credential)).user;

      showSnackbar("Successfully signed in UID: ${user.uid}", ctx);

      notifyListeners();
      return user.uid;
    } catch (e) {
      showSnackbar("Verification failed $e", ctx);
      notifyListeners();
      return "error";
    }
  }

  void showSnackbar(String message, BuildContext ctx) {
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text('$message'),
      duration: Duration(seconds: 3),
    ));
    print(message);
  }
}
