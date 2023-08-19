import 'package:flutter/material.dart';
import 'package:letsgo/Utils/pallete.dart';

import '../Utils/size_controller.dart';

class SettingdItem extends StatelessWidget {
  SettingdItem({Key? key, required this.itemName, required this.iconData})
      : super(key: key);
  final String itemName;

  final String iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getHeight(80),
      width: AppLayout.getWidth(275),
      margin: EdgeInsets.all(AppLayout.getHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: heading8,
          ),
          SizedBox(
            width: AppLayout.getHeight(90),
            height: AppLayout.getHeight(90),
            child: Center(
              child: Container(
                child: Image.asset(
                  iconData,
                  width: AppLayout.getWidth(30),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
