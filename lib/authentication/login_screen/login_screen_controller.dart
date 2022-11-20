import 'package:ecommerce_clone/home_screen/home_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../otp_verification_screen/otp_screen_view.dart';

class LoginScreenController extends GetxController {
  bool isLoading = true;
  TextEditingController phone = TextEditingController();
  TextEditingController opt = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";

  void verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+92${phone.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            print('verified');
          },
          verificationFailed: (FirebaseAuthException exception) {
            print('verification failed');
          },
          codeSent: (String _verificationId, int? forceRespondToken) {
            print('verification code sent');
            verificationId = _verificationId;

            Get.to(() => const OtpVerificationScreen());
          },
          codeAutoRetrievalTimeout: (String _verificationId) {
            verificationId = _verificationId;
          });
    } catch (e) {
      print(e);
    }
    isLoading = false;
    update();
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: opt.text);
      var signInUser = await _auth.signInWithCredential(credential);
      final User? user = signInUser.user;

      print("Sign In Sucessfully, User UID : ${user!.uid}");
      Get.to(HomeScreenView());
    } catch (e) {
      print("Error Occured : $e");
    }
  }
}
