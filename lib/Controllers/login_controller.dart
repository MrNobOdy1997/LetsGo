import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgo/Screens/BottomNavigationBar/bottom_bar.dart';
import 'package:letsgo/Utils/size_controller.dart';

import '../Models/socialMediaSignInUser.dart';
import '../Models/user_details_model.dart';
import 'firebase_controller.dart';

class LoginController extends GetxController {
  late TextEditingController userEmailController;
  late TextEditingController passwordController;
  final FirebaseController _firebaseController = Get.put(FirebaseController());

  @override
  void onInit() {
    userEmailController = TextEditingController();
    passwordController = TextEditingController();
    log("width...${AppLayout.getScreenWidth()}");
    log("applayoutwidth...${AppLayout.getWidth(100)}");
    super.onInit();
  }

  void loginUser() {
    if (_firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      _firebaseController.login(
          userEmailController.text, passwordController.text);
    }

    log("dataaaa${userEmailController.text},${passwordController.text}");
  }

  Future<User?> SignInWithGoogle() async {
    if (_firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
          if (user != null) {
            AppLayout.customToast('Sign in successful');
            UserData smsUserData = UserData(
                id: user.uid,
                userName: user.displayName!,
                mailId: user.email!,
                password: "",
                phoneNumber: "",
                sms: true);

            socialMediaSignIn(smsUserData);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            AppLayout.customToast(
                'The account already exists with a different credential.');
          } else if (e.code == 'invalid-credential') {
            AppLayout.customToast('Error occurred while accessing credentials. Try again.');
          }
        } catch (e) {
          AppLayout.customToast("Error occurred using Google Sign-In. Try again.");
        }
      }
      return user;
    }
  }


  void socialMediaSignIn(UserData smsUserData) async {
    log("mediadata.... ${smsUserData.mailId}");
    CollectionReference reference =
        FirebaseFirestore.instance.collection("Users");
    reference
        .doc(smsUserData.id)
        .set(smsUserData.toMap())
        .then((value) => Get.offAll(BottomBar()));
  }
}
