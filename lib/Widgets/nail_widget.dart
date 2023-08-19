import 'package:flutter/material.dart';

import '../Utils/size_controller.dart';

class NailWidget extends StatelessWidget {
  const NailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin:   EdgeInsets.only(left:  AppLayout.getHeight(5), right:  AppLayout.getHeight(5)),
      decoration:  const BoxDecoration(
          shape: BoxShape.circle, color:  Color(0xfffb7410e),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 12,
              spreadRadius: 2, //New
            )
          ]),
      height:  AppLayout.getHeight(12),
      width:  AppLayout.getHeight(12),
      child:Container(
        margin:   EdgeInsets.only(left:  AppLayout.getHeight(3), right:  AppLayout.getHeight(3)),
        decoration:  const BoxDecoration(
            shape: BoxShape.circle, color:  Colors.black,),
        height:  AppLayout.getHeight(8),
        width:  AppLayout.getHeight(8),
      ) ,
    );
  }
}
