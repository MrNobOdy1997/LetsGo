import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {   // method to handle bottom navigation tab changing
    tabIndex.value = index;

    update();
  }

}