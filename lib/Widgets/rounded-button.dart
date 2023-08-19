import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/login_controller.dart';
import 'package:letsgo/Controllers/reg_controller.dart';
import 'package:sizer/sizer.dart';

import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({Key? key, required this.buttonName, required this.onTap})
      : super(key: key);
  LoginController loginController = Get.put(LoginController());
  RegistrationController registrationController =
      Get.put(RegistrationController());
  final String buttonName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height:6.h,
      width: 30.w,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(top: 1, bottom: 1, left: 1, right: 1),
      child: TextButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.background,
         // primary: context.theme.colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide(
            color: context.theme.colorScheme.surface,
          ), //<-- SEE HERE
        ),
        onPressed: onTap,
        child: Container(
          padding: EdgeInsets.only(
              top: AppLayout.getHeight(1),
              bottom: AppLayout.getHeight(1),
              left: AppLayout.getHeight(1),
              right: AppLayout.getHeight(1)),
          child: Text(
            buttonName,
            style: TextStyle(fontSize: 14.sp, color: context.theme.colorScheme.secondary,fontWeight: FontWeight.bold,)

            // heading2.copyWith(fontWeight: FontWeight.bold,color: context.theme.colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
