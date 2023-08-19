import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';

class EmergencyItemWidget extends StatelessWidget {
  const EmergencyItemWidget(
      {Key? key,
      required this.itemName,
      required this.iconData,
      required this.contactNumber})
      : super(key: key);
  final String itemName;

  final String iconData;
  final String contactNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getHeight(80),
      width: double.infinity,
      margin: EdgeInsets.all(AppLayout.getHeight(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width:8.w,
            height:8.h,
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
          Text(
            itemName,
            style:  TextStyle(fontSize: 10.sp, color: textColor, fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {
              var url = Uri.parse("tel:$contactNumber");
              launchUrl(url);
            },
            child: SizedBox(
                width: 8.w,
                height: 8.h,
                child: const Icon(FluentSystemIcons.ic_fluent_call_add_filled,
                    color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
