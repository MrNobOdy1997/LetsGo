import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Utils/size_controller.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/reg_controller.dart';
import '../Utils/pallete.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controller,
    this.inputType,
    this.inputAction,
  }) : super(key: key);
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    RegistrationController registrationController = Get.put(RegistrationController());
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:1.h),
      child: Container(
        height:9.h,
        width: 70.w,
        decoration: BoxDecoration(
         // color: Colors.blue[200]!.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),

        child: Center(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: hint,
              labelStyle:   TextStyle(color: Colors.blueGrey,fontSize: 16.sp,fontWeight: FontWeight.w500),
              prefixIcon: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: .5.h),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color:  Colors.blueGrey,
                ),
              ),
              hintStyle: heading1,
            ),
            style: heading1,
            keyboardType: inputType,
            textInputAction: inputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator:
                (value){
              if(hint == "UserName"){
                if (value!.isEmpty) {
                  return 'Please enter First name';
                }


              }
              else if(hint == "Email"){
                if (value!.isEmpty) {
                  return 'Please enter EmailId';
                } else if (registrationController.isEmailValid(value)) {
                  return null;
                }
                return "Enter a valid mail Id";
              }
              else if (hint=="Phone Number"){
                if (value!.isEmpty) {
                  return 'Please enter a Password';
                } else if (value.length < 10 || value.length > 10) {
                  return ("please enter a valid phone number");
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
