import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Screens/SplashScreen/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'Controllers/theme_service_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  ThemeService themeController = Get.put(ThemeService());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return  Sizer(
        builder: (context, orientation, deviceType)
    {
      return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeController.themeLight(),
          darkTheme: themeController.themeLight(),
          themeMode: ThemeService().theme,
          home:
          SplashScreen() //Loads Splash screen
      );
    });
  }
}

