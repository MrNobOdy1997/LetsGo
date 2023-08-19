import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:letsgo/Models/user_details_model.dart';

import '../Utils/size_controller.dart';

class SettingsController extends GetxController{

  RxString username = "".obs;
  RxString userId = "".obs;
  RxString mailId = "".obs;
  RxString phnNumber = "".obs;
  late TextEditingController userName;
  late TextEditingController emailId;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late TextEditingController phoneNumber;
  late TextEditingController otpField; 
  late FirebaseController firebaseController;




  @override
  void onInit() {
    firebaseController = Get.put(FirebaseController());
    userName = TextEditingController();
    emailId = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    phoneNumber = TextEditingController();
    getCurrentUserDetails();
    log("setting init called...");
  }
  getCurrentUserDetails() async {
    var currentUserDetails = await firebaseController.getUserData();
    if (currentUserDetails == null) {
      AppLayout.customToast("Could't get current user details");
    } else {
      username.value = currentUserDetails['userName'];
      userId.value = currentUserDetails['id'];
      mailId.value = currentUserDetails['mailId'];
      phnNumber.value = currentUserDetails['phoneNumber'];
      var userdata = UserData.fromDocumentSnapshot(documentSnapshot: currentUserDetails);
      var finalresult = UserData(id: userdata.id, userName: userdata.userName, mailId: userdata.mailId, password: userdata.password, phoneNumber: userdata.phoneNumber, sms: userdata.sms);
      log("setting init called... ${finalresult.userName}");
    }
  }
  userSignOut(){

    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet then SignOut");
    } else {
      firebaseController.signOut();
    }





  }

  void registerUser(BuildContext context) {}

}