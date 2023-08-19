import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:letsgo/Controllers/login_controller.dart';
import 'package:letsgo/Widgets/custom_richtext.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/pallete.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/background-image.dart';
import '../../Widgets/googleSignInButton.dart';
import '../../Widgets/password-input.dart';
import '../../Widgets/rounded-button.dart';
import '../../Widgets/text-field-input.dart';

import '../RegistrationScreen/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  final _loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SafeArea(
      child: Stack(
        children: [
          const BackgroundImage(
            image: 'assets/images/loginbg.webp',
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _loginformKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppLayout.getHeight(150),
                    ),
                    const Center(
                      child: Text(
                        'Lets Go',
                        style: TextStyle(
                            fontFamily: "BerkshireSwash",
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getWidth(100),
                    ),
                    Container(
                      height: 30.h,
                      width: size.width * .80,
                      padding: EdgeInsets.all(2.h),
                      margin: EdgeInsets.only(
                          left: AppLayout.getHeight(25),
                          top: 0.0,
                          right: AppLayout.getHeight(25),
                          bottom: 0.0),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.background.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextInputField(
                            controller: loginController.userEmailController,
                            icon: FontAwesomeIcons.envelope,
                            hint: 'Email',
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                          ),
                          PasswordInput(
                            controller: loginController.passwordController,
                            icon: FontAwesomeIcons.lock,
                            hint: 'Password',
                            inputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgotPassword'),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: kBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                     SizedBox(
                      height:  AppLayout.getHeight(25),
                    ),
                    RoundedButton(
                      buttonName: 'Login',
                      onTap: () {
                        if (_loginformKey.currentState!.validate()) {
                          loginController.loginUser();
                          // AppLayout.customToast("success");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        padding:  EdgeInsets.fromLTRB( AppLayout.getHeight(100), 0,  AppLayout.getHeight(100), 0),
                        child: GoogleSignInButton()
                    ),

                     SizedBox(
                      height:  10.h,
                    ),

                    CustomRichText(
                      discription: "Don't already Have an account? ",
                      text: "Sign Up",
                      onTap: () {
                         Get.to(() => CreateNewAccount());
                      },
                    ),
                    SizedBox(
                      height:  1.h,
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
