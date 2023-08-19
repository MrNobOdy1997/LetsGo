import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Screens/LoginScreen/login_page.dart';
import 'package:letsgo/Utils/pallete.dart';
import 'package:letsgo/Widgets/emergency_contact_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/theme_service_controller.dart';
import '../../Utils/pallete.dart';
import '../../Controllers/settings_page_controller.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/app_bar_widget.dart';
import '../../Widgets/setting_item_widget.dart';
import '../../Widgets/theme_pallete_widget.dart';
import '../ProfileScreen/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  SettingsController settingsController = Get.put(SettingsController());
  ThemeService themeController = Get.put(ThemeService());
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  context.theme.colorScheme.background,
                  context.theme.colorScheme.primary,
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                tileMode: TileMode.mirror),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppLayout.getHeight(16),
                  vertical: AppLayout.getHeight(73)),
              child: Column(
                children: [
                  SizedBox(
                    height: AppLayout.getHeight(10),
                  ),
                  Text('Your Profile',
                      textAlign: TextAlign.center, style: heading5.copyWith(fontSize: 32,color:  Colors.black)),
                  SizedBox(
                    height: AppLayout.getHeight(22),
                  ),
                  Container(
                    height: AppLayout.getHeight(400),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.75,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color:  context.theme.colorScheme.surface),
                                    boxShadow:  [
                                      BoxShadow(
                                          color:  context.theme.colorScheme.secondary,
                                          blurRadius: 2,
                                          spreadRadius: 1)
                                    ]),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: AppLayout.getHeight(80),
                                    ),
                                    Text(
                                      settingsController.username.value,
                                      style:  TextStyle(
                                        color: context.theme.colorScheme.secondary,
                                        fontFamily: 'Nunito',
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppLayout.getHeight(5),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              settingsController.mailId.value,
                                              style:  const TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppLayout.getHeight(25),
                                            vertical: AppLayout.getWidth(8),
                                          ),
                                          child: Container(
                                            height: AppLayout.getHeight(3),
                                            width: AppLayout.getWidth(200),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: context.theme.colorScheme.secondary)),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'User Id',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              settingsController.userId.value,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppLayout.getHeight(25),
                                            vertical: AppLayout.getWidth(8),
                                          ),
                                          child: Container(
                                            height: AppLayout.getHeight(3),
                                            width: AppLayout.getWidth(200),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: context.theme.colorScheme.secondary)),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Phone No',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              settingsController.phnNumber
                                                  .value,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/avatar.png',
                                    width: innerWidth * 0.45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppLayout.getHeight(30),
                  ),
                  Container(
                    height: AppLayout.getHeight(500),
                    width: AppLayout.getScreenWidth(),
                    decoration: BoxDecoration(
                        color:kWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color:  context.theme.colorScheme.surface),
                        boxShadow:  [
                          BoxShadow(
                              color: context.theme.colorScheme.secondary,
                              blurRadius: 2,
                              spreadRadius: 1)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getHeight(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Text('App Settings',
                              style: heading3.copyWith(
                                  color:
                                  context.theme.colorScheme.secondary)),
                          Divider(
                            thickness: AppLayout.getHeight(3),
                            color:  context.theme.colorScheme.secondary,
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(25),
                          ),
                          InkWell(
                            onTap: () {
                              Future.delayed(const Duration(seconds: 1), () {
                                // ignore: avoid_print
                                print(Get.isBottomSheetOpen);
                              });

                              Get.bottomSheet(
                                Container(
                                  height: AppLayout.getHeight(300),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Center(
                                        child: Text(
                                          "Choose a theme",
                                          style: heading3.copyWith(color:  context.theme.colorScheme.secondary),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ThemePallete(
                                            onTap: () {
                                              themeController.mode.value = "Maroon";
                                              themeController.themeLight();
                                              AppLayout.customToast("Maroon");
                                            },
                                            palleteColor:
                                            const Color(0xffA600B1),
                                          ),
                                           SizedBox(
                                            width: .5.h,
                                          ),

                                          ThemePallete(
                                            onTap: () {
                                              themeController.mode.value = "Orange";
                                              themeController.themeLight();
                                              AppLayout.customToast("orange");
                                            },
                                            palleteColor:
                                            const Color(0xffFE3F0C),
                                          ),
                                           SizedBox(
                                            width: .5.h,
                                          ),
                                          ThemePallete(
                                            onTap: () {
                                              themeController.mode.value = "Green";
                                              themeController.themeLight();
                                              AppLayout.customToast("green");
                                            },
                                            palleteColor:
                                            const Color(0xff169D39),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          ThemePallete(
                                            onTap: () {
                                              themeController.mode.value = "Yellow";
                                              themeController.themeLight();
                                              AppLayout.customToast("yellow");
                                            },
                                            palleteColor:
                                            const Color(0xffF8D400),
                                          ),

                                           SizedBox(
                                            width: .5.h,
                                          ),
                                          ThemePallete(
                                            onTap: () {
                                              themeController.mode.value = "Red";
                                              themeController.themeLight();
                                              AppLayout.customToast("Red");
                                            },
                                            palleteColor:
                                            const Color(0xffC20000),
                                          ),
                                           SizedBox(
                                            width: .5.h,
                                          ),
                                          ThemePallete(
                                            onTap: () {
                                              themeController.mode.value = "Blue";
                                              themeController.themeLight();
                                              AppLayout.customToast("Grey");
                                            },
                                            palleteColor:
                                            const Color(0xff4977A0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                elevation: 80.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                            child: Container(
                              height: AppLayout.getHeight(70),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                border: Border.all(color:  context.theme.colorScheme.surface),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SettingdItem(
                                itemName: 'Change Theme',
                                iconData: 'assets/images/colorpalette.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(25),
                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                backgroundColor: Colors.transparent,
                                titleStyle: const TextStyle(
                                    color: Colors.transparent),
                                middleTextStyle: const TextStyle(
                                    color: Colors.transparent),
                                content: const EmergencyContactWidget(),
                              );
                            },
                            child: Container(
                              height: AppLayout.getHeight(70),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                border: Border.all(color:  context.theme.colorScheme.surface),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SettingdItem(
                                itemName: 'Emergency',
                                iconData: 'assets/images/emergencycall.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(25),
                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                backgroundColor: Colors.transparent,
                                titleStyle: const TextStyle(
                                    color: Colors.transparent),
                                middleTextStyle: const TextStyle(
                                    color: Colors.transparent),
                                content: Container(
                                  margin: const EdgeInsets.only(
                                      right: 2, bottom: 15, left: 2),
                                  width: AppLayout.getWidth(225),
                                  height: AppLayout.getHeight(225),
                                  child: Stack(
                                    children: [
                                    Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Center(
                                        child: Container(
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  Radius.circular(30)),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                margin: EdgeInsets.only(
                                                    right: AppLayout.getHeight(
                                                        20)),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    image: const DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/letsgo.png"))),
                                              )
                                          ),
                                        ),
                                      ),
                                      Center(

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              'Lets Go',
                                              style: heading5.copyWith(
                                                  fontFamily: "BerkshireSwash",
                                                  color: Colors.amber),
                                            ),
                                             Text(
                                              " Version 1.0.0",
                                              style: heading8.copyWith(color: Colors.white),
                                            ),
                                             SizedBox(height: AppLayout.getHeight(25),),
                                             Text(
                                              "© 2022 Innovature. All rights reserved.",
                                              style: heading9,
                                            )
                                          ],
                                        ),

                                      )],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: AppLayout.getHeight(70),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                border: Border.all(color: context.theme.colorScheme.surface),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SettingdItem(
                                itemName: 'App Info',
                                iconData: 'assets/images/info.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(25),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Confirm'),
                                      content: const Text(
                                          'Do you wish to logout?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text(
                                            'Cancel',
                                            style:
                                            TextStyle(color: Colors.redAccent),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await settingsController
                                                .userSignOut();
                                            // Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK',
                                              style:
                                              TextStyle(color: Colors.green)),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            child: Container(
                              height: AppLayout.getHeight(70),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                border: Border.all(color: context.theme.colorScheme.surface),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: AppLayout.getHeight(80),
                                width: AppLayout.getWidth(275),
                                margin: EdgeInsets.all(AppLayout.getHeight(10)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Logout",
                                      style: heading8,
                                    ),
                                    SizedBox(
                                        width: AppLayout.getHeight(90),
                                        height: AppLayout.getHeight(90),
                                        child: Icon(
                                          FluentSystemIcons
                                              .ic_fluent_sign_out_regular,
                                          color: Colors.redAccent.shade200,
                                          size: AppLayout.getHeight(35),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
