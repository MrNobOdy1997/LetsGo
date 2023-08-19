import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';
import 'emergency_item_widget.dart';

class EmergencyContactWidget extends StatelessWidget {
  const EmergencyContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 80.w,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.theme.colorScheme.surface),
          boxShadow: [
            BoxShadow(
                color: context.theme.colorScheme.secondary,
                blurRadius: 2,
                spreadRadius: 1)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(10)),
        child: Column(
          children: [
            SizedBox(
              height:1.5.h,
            ),
            Text('Emergency Contacts',
                style: TextStyle(
                    color: const Color.fromRGBO(185, 51, 34, 1.0),
                fontSize: 18.sp,fontWeight: FontWeight.bold)),
            Divider(
              thickness: AppLayout.getHeight(1),
              color: context.theme.colorScheme.secondary,
            ),
            SizedBox(
              height:1.5.h,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height:8.h,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  border: Border.all(color: context.theme.colorScheme.surface),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const EmergencyItemWidget(
                  itemName: 'Police Station',
                  iconData: 'assets/images/policeman.png',
                  contactNumber: '9746625623',
                ),
              ),
            ),
            SizedBox(
              height:1.5.h,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height:8.h,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  border: Border.all(color: context.theme.colorScheme.surface),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const EmergencyItemWidget(
                    itemName: 'Fire Station',
                    iconData: 'assets/images/firefighter.png',
                    contactNumber: '9746625623'),
              ),
            ),
            SizedBox(
              height:1.5.h,
            ),
            InkWell(
              child: Container(
                height:8.h,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  border: Border.all(color: context.theme.colorScheme.surface),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const EmergencyItemWidget(
                    itemName: 'Ambulance',
                    iconData: 'assets/images/ambulance.png',
                    contactNumber: '9746625623'),
              ),
            ),
            SizedBox(
              height:1.5.h,
            ),
            InkWell(
              child: Container(
                height:8.h,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  border: Border.all(color: context.theme.colorScheme.surface),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const EmergencyItemWidget(
                    itemName: 'Women Cell',
                    iconData: 'assets/images/call.png',
                    contactNumber: '9746625623'),
              ),
            ),
            SizedBox(
              height:1.5.h,
            ),
            InkWell(
              child: Container(
                height:8.h,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  border: Border.all(color: context.theme.colorScheme.surface),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const EmergencyItemWidget(
                    itemName: 'Child Line',
                    iconData: 'assets/images/childline.png',
                    contactNumber: '9746625623'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
