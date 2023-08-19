import 'package:flutter/material.dart';
import 'package:letsgo/Utils/size_controller.dart';
import 'package:letsgo/Widgets/nail_widget.dart';
import 'package:sizer/sizer.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({Key? key, required this.placeName, required this.placeDistrict}) : super(key: key);
  final String placeName;
  final String placeDistrict;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width:50.w,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black12),
        borderRadius: const BorderRadius.all( Radius.circular(10.0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffb5b4b8),
            blurRadius: .1,
            spreadRadius: 2, //New
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const NailWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Text(
                placeName,
                style:  TextStyle(
                    fontFamily: "BerkshireSwash",
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                placeDistrict,
                style:  TextStyle(
                    fontFamily: "BerkshireSwash",
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
    const NailWidget(),
        ],
      ),
    );
  }
}
