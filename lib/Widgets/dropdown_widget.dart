import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:letsgo/Controllers/explore_page_controller.dart';
import 'package:letsgo/Utils/pallete.dart';
import 'package:letsgo/Utils/size_controller.dart';
import '../Utils/Constants.dart';

class DropdownButtonExample extends StatelessWidget {
  const DropdownButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExploreController exploreController = Get.put(ExploreController());
    return Obx(() => Container(
            child: Column(children: [
          Text(
            "Choose District",
            style:
                heading6.copyWith(color: context.theme.colorScheme.secondary),
          ),
          SizedBox(
            height: AppLayout.getHeight(5),
          ),
          DropdownButton<String>(
            value: exploreController.selectedDistrict.value,
            icon: Icon(
              FluentSystemIcons.ic_fluent_arrow_down_regular,
              color: context.theme.colorScheme.surface,
            ),
            elevation: 5,
            style: heading2,
            underline: Container(
              height: 2,
              color: context.theme.colorScheme.surface,
            ),
            onChanged: (String? value) {
              exploreController.selectedDistrict.value = value!;
            },
            items: Districts.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(
            height: AppLayout.getHeight(10),
          ),
        ])));
  }
}
