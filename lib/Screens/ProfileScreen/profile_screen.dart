import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/settings_page_controller.dart';
import '../../Utils/pallete.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/rounded-button.dart';
import '../../Widgets/text-field-input.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final profileditformkey = GlobalKey<FormState>();
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromRGBO(165, 186, 243, 1.0),
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                tileMode: TileMode.mirror),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            autovalidateMode: AutovalidateMode.always,
            key: profileditformkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.2,
                  ),
                  SizedBox(
                    height: AppLayout.getHeight(10),
                  ),
                  Text('Your Profile',
                      textAlign: TextAlign.center, style: heading5),
                  SizedBox(
                    height: AppLayout.getHeight(42),
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.18,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/avatar.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      Container(
                        height: AppLayout.getHeight(300),
                        width: size.width * .80,
                        margin: const EdgeInsets.only(
                            left: 25.0, top: 0.0, right: 25.0, bottom: 0.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[400]!.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextInputField(
                              controller: settingsController.userName,
                              icon: FontAwesomeIcons.user,
                              hint: 'UserName',
                              inputType: TextInputType.name,
                              inputAction: TextInputAction.next,
                            ),
                            TextInputField(
                              icon: FontAwesomeIcons.envelope,
                              controller: settingsController.emailId,
                              hint: 'Email',
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                            ),
                            TextInputField(
                              icon: FontAwesomeIcons.phone,
                              controller: settingsController.phoneNumber,
                              hint: 'Phone Number',
                              inputType: TextInputType.phone,
                              inputAction: TextInputAction.next,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundedButton(
                        buttonName: 'Update',
                        onTap: () {
                          if (profileditformkey.currentState!.validate()) {
                            settingsController.registerUser(context);
                          }
                        },
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
