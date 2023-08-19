import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Screens/BottomNavigationBar/bottom_bar.dart';
import '../Controllers/login_controller.dart';
import '../Utils/size_controller.dart';



class GoogleSignInButton extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: AppLayout.getHeight(4)),
      child: Container(
        height: AppLayout.getHeight(60),
        width: AppLayout.getWidth(60),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:Colors.white,
            primary: Colors.amber,
            shape:const CircleBorder() ,
            // shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),

            side:  BorderSide(color:context.theme.colorScheme.surface, width: 1,), //<-- SEE HERE
          ),
          onPressed: () async {
           User? user =  await loginController.SignInWithGoogle();
            if (user != null) {
              Get.offAll(BottomBar());
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(0, AppLayout.getHeight(2), 0, AppLayout.getHeight(2)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                Image(
                  image: const AssetImage('assets/images/google.png'),
                  height: AppLayout.getHeight(20),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: AppLayout.getHeight(8)),
                //   child: const Text(
                //     'GoogleSignIn',
                //     style: TextStyle(
                //       fontSize: 10,
                //       color: Colors.amber,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}