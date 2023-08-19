import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Screens/FavouriteScreen/favourite_page.dart';
import 'package:letsgo/Screens/SettingsScreen/settings_page.dart';
import 'package:letsgo/Utils/pallete.dart';
import '../../Controllers/bottomnav_controller.dart';
import '../../Utils/size_controller.dart';
import '../ExploreScreen/explorer_page.dart';

class BottomBar extends StatelessWidget {
   BottomBar({Key? key}) : super(key: key);
 final  BottomNavigationController bottomNavController = Get.put(BottomNavigationController());
  static final List<Widget> _widgetOptions = <Widget>[
     ExplorerScreen(),
     FavouriteScreen(),
     SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
     body: Center(
         child: _widgetOptions[bottomNavController.tabIndex.toInt()]),

      bottomNavigationBar: Container(
        height:AppLayout.getHeight(65),
        width:AppLayout.getWidth(181),
        margin:  EdgeInsets.only(
            left:AppLayout.getHeight(15), top: 0.0, right: AppLayout.getHeight(15), bottom: AppLayout.getHeight(20)),
        padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(width: .5, color: context.theme.colorScheme.surface),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: context.theme.colorScheme.secondary,
          selectedItemColor:context.theme.colorScheme.surface,
                      onTap: bottomNavController.changeTabIndex,
                      currentIndex: bottomNavController.tabIndex.toInt(),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
            elevation: 0.0,

            items: const [
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_earth_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_earth_filled),
                  label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_heart_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_heart_filled), label: "Favourite"),
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_settings_dev_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_settings_dev_filled), label: "Setting"),
            ],
          ),
      ),
      backgroundColor: context.theme.colorScheme.background,

    )
    );
  }
}
