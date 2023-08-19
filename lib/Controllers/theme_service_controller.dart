import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxController {
  RxString mode = "".obs;

  //
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeData themeLight() {
    if (mode == "Maroon") {
      final violet = ThemeData.light().copyWith(
          backgroundColor: Colors.purple.shade50,
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
            primary: const Color.fromRGBO(187, 128, 241, 1.0),
            background: const Color.fromRGBO(252, 249, 255, 1.0),
            secondary: const Color.fromRGBO(115, 9, 155, 1.0),
            brightness: Brightness.dark,
            surface: const Color.fromRGBO(28, 4, 37, 1.0),
          ));
      Get.changeTheme(violet);

      return violet;
    } else if (mode == "Red") {

      final red = ThemeData.dark().copyWith(
          backgroundColor: Colors.amber.shade200,
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
            primary: const Color.fromRGBO(241, 150, 150, 1.0),
            background: const Color.fromRGBO(255, 249, 249, 1.0),
            secondary: const Color.fromRGBO(208, 6, 6, 1.0),
            surface: const Color.fromRGBO(91, 8, 8, 1.0),
            brightness: Brightness.dark,
          ));
      Get.changeTheme(red);

      return red;
    } else if (mode == "Orange") {

      final Orange = ThemeData.dark().copyWith(
          backgroundColor: Colors.orange.shade50,
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(
            primary: const Color.fromRGBO(243, 183, 137, 1.0),
            background: const Color.fromRGBO(255, 251, 250, 1.0),
            secondary: const Color.fromRGBO(208, 128, 7, 1.0),
            surface: const Color.fromRGBO(108, 71, 17, 1.0),
            brightness: Brightness.dark,
          ));
      Get.changeTheme(Orange);

      return Orange;
    } else if (mode == "Yellow") {

      final yellow = ThemeData.dark().copyWith(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.amber).copyWith(
        primary: const Color.fromRGBO(237, 246, 17, 1.0),
        background: const Color.fromRGBO(253, 253, 235, 1.0),
        secondary: const Color.fromRGBO(143, 141, 16, 1.0),
        surface: const Color.fromRGBO(80, 77, 14, 1.0),
        brightness: Brightness.dark,
      ));
      Get.changeTheme(yellow);

      return yellow;
    } else if (mode == "Green") {

      final light = ThemeData.light().copyWith(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
        primary: const Color.fromRGBO(145, 243, 152, 1.0),
        background: const Color.fromRGBO(246, 252, 245, 1.0),
        secondary: const Color.fromRGBO(21, 121, 21, 1.0),
        surface: const Color.fromRGBO(14, 68, 14, 1.0),
        brightness: Brightness.dark,
      ));
      Get.changeTheme(light);

      return light;
    }
    else if (mode == "Blue") {

      final grey = ThemeData.dark().copyWith(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        primary: const Color.fromRGBO(94, 212, 238, 1.0),
        background: const Color.fromRGBO(242, 247, 250, 1.0),
        secondary: const Color.fromRGBO(8, 125, 171, 1.0),
        surface: const Color.fromRGBO(15, 57, 79, 1.0),
        brightness: Brightness.dark,
      ));
      Get.changeTheme(grey);

      return grey;
    } else {
      final light = ThemeData.light().copyWith(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
        primary: const Color.fromRGBO(140, 243, 152, 1.0),
        background: const Color.fromRGBO(246, 252, 245, 1.0),
        secondary: const Color.fromRGBO(21, 121, 21, 1.0),
        surface: const Color.fromRGBO(17, 72, 17, 1.0),
        brightness: Brightness.dark,
      ));

      return light;
    }
  }

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme(String mode) {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
