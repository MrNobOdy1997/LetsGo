import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../Controllers/reg_controller.dart';
import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controller,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RegistrationController registrationController =
        Get.put(RegistrationController());
    return Padding(
      padding: EdgeInsets.symmetric(vertical:1.h),
      child: Container(
        height:11.h,
        width: 70.w,
        decoration: BoxDecoration(
          //   color: Colors.blue[500]!.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: TextFormField(
            controller: controller,
            maxLength: 20,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: hint,
              labelStyle:  TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
              prefixIcon: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: .5.h),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color: Colors.blueGrey,
                ),
              ),
              hintStyle: heading1,
            ),
            obscureText: true,
            style: heading1,
            keyboardType: inputType,
            textInputAction: inputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (hint == "Password") {
                if (value!.isEmpty) {
                  return 'Please enter a Password';
                } else if (value.length < 8 || value.length > 20) {
                  return ("Minimum characters is 8 and maximum is 20");
                } else {
                  if (registrationController.isPasswordValid(value)) {
                    return null;
                  } else {
                    return "A digit, lower & uppercase letter and a special symbol must be included";
                  }
                }
              } else if (hint == "Confirm Password") {
                if (value!.isEmpty) {
                  return 'Please confirm Password';
                } else if (value != registrationController.password.text) {
                  log("value: $value and password ${registrationController.password.text}");
                  return "password and confirm password mismatch";
                }
                return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
