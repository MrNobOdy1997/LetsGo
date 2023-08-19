import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/reg_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/pallete.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/background-image.dart';
import '../../Widgets/custom_richtext.dart';
import '../../Widgets/password-input.dart';
import '../../Widgets/rounded-button.dart';
import '../../Widgets/text-field-input.dart';
import '../LoginScreen/login_page.dart';

class CreateNewAccount extends StatelessWidget {
  CreateNewAccount({Key? key}) : super(key: key);
  final _regformKey = GlobalKey<FormState>();
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/regbg.webp'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _regformKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.2,
                  ),
                  Stack(
                    children: [
                      Center(
                        child:
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(right: AppLayout.getHeight(20)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/images/letsgo.png"))),
                              )

                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      Container(
                        height:70.h,
                        width: 80.w,
                        margin:  const EdgeInsets.only(
                            left: 25.0, top: 0.0, right: 25.0, bottom: 0.0),
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.background
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                             SizedBox(
                              height: 4.h,
                            ),
                            TextInputField(
                              controller: registrationController.userName,
                              icon: FontAwesomeIcons.user,
                              hint: 'UserName',
                              inputType: TextInputType.name,
                              inputAction: TextInputAction.next,
                            ),
                            TextInputField(
                              icon: FontAwesomeIcons.envelope,
                              controller: registrationController.emailId,
                              hint: 'Email',
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                            ),
                            TextInputField(
                              icon: FontAwesomeIcons.phone,
                              controller: registrationController.phoneNumber,
                              hint: 'Phone Number',
                              inputType: TextInputType.phone,
                              inputAction: TextInputAction.next,
                            ),
                            PasswordInput(
                              icon: FontAwesomeIcons.lock,
                              controller: registrationController.password,
                              hint: 'Password',
                              inputAction: TextInputAction.next,
                            ),
                            PasswordInput(
                              icon: FontAwesomeIcons.lock,
                              controller:
                                  registrationController.confirmPassword,
                              hint: 'Confirm Password',
                              inputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        buttonName: 'Register',
                        onTap: () {
                          if (_regformKey.currentState!.validate()) {
                            registrationController.registerUser(context);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRichText(
                            discription: "Already have an account? ",
                            text: "Login",
                            onTap: () {
                              Get.to(() => LoginScreen());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
