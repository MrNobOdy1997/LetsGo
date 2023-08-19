import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:letsgo/Screens/BottomNavigationBar/bottom_bar.dart';
import 'package:letsgo/Utils/size_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Models/user_details_model.dart';
import '../Widgets/rounded-button.dart';

class RegistrationController extends GetxController {
  final GlobalKey<FormState> regformkey = GlobalKey<FormState>();
  var userdata = <UserData>[].obs;
  late TextEditingController userName;
  late TextEditingController emailId;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late TextEditingController phoneNumber;
  late TextEditingController otpField;
  late RoundedLoadingButtonController _btnController;

  final FirebaseController _firebaseController = Get.put(FirebaseController());

  @override
  void onInit() {
    userName = TextEditingController();
    emailId = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    phoneNumber = TextEditingController();
    otpField = TextEditingController();
    _btnController = RoundedLoadingButtonController();

    super.onInit();
  }

//validating the form before creating user
  bool checkLogin() {
    final isValid = regformkey.currentState!.validate();
    if (!isValid) {
      return isValid;
    }
    regformkey.currentState!.save();
    return isValid;
  }

//password validation
  bool isPasswordValid(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(password);
  }

  //email validation
  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
  void openBottomSheet(String verificationId) {


    print(Get.isBottomSheetOpen);


    Get.bottomSheet(
      Container(
        height: AppLayout.getHeight(250),
        child: Column(
          children: [
            SizedBox(height: AppLayout.getHeight(30)),
            const Center(
              child: Text(
                'Please enter the OTP recieved',
                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
              ),
            ),
            // Column(children: <Widget>[
            SizedBox(height: AppLayout.getHeight(5)),
            Padding(
              padding: EdgeInsets.only(
                  left: AppLayout.getHeight(5),
                  top: AppLayout.getHeight(5),
                  right: AppLayout.getHeight(5),
                  bottom: AppLayout.getHeight(5)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: AppLayout.getHeight(15),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: AppLayout.getHeight(60),
                        width: AppLayout.getHeight(150),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: otpField,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "OTP",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppLayout.getHeight(15)),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: RoundedLoadingButton(
                          controller: _btnController,
                          onPressed: () =>

                              verifyOtp(otpField.text, verificationId),
                          successColor: Colors.lightGreen,
                          color: Colors.lightBlue,
                          child: const Text('Verify',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // ]),
          ],
        ),
      ),
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.white.withOpacity(1.0),
      elevation: 100.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  // +919496865606
  Future getOtp(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var number = "+91$mobile";
    log("phone ..$number");
    _auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {

        //This callback would gets called when verification is done auto maticlly
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationFailed: (FirebaseAuthException error) {
        print("error  ..${error.code}");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        //     log("Inside codesent callback");
        openBottomSheet(verificationId);
      },
    );
  }

  void registerUser(BuildContext context) {
    if(_firebaseController.netWorkStatus == false){
      AppLayout.customToast("Please turn on your internet");
    }else{
      getOtp(phoneNumber.text, context);
    }

  }

  void verifyOtp(String text, String verificationId) async {
    if(_firebaseController.netWorkStatus == false){
      AppLayout.customToast("Please turn on your internet");
    }else{

      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: text);
      if (credential == null) {
        AppLayout.customToast("errorrrrr");
        _btnController.error();
      } else {
        _firebaseController.register(
            userName.text, emailId.text, password.text, phoneNumber.text);
        _btnController.success();
        //  Get.to(() => BottomBar());

        AppLayout.customToast("success");
      }
    }

  }

}
