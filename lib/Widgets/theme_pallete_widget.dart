import 'package:flutter/material.dart';
import 'package:letsgo/Utils/size_controller.dart';

class ThemePallete extends StatelessWidget {
  const ThemePallete({Key? key, required this.palleteColor, required this.onTap}) : super(key: key);
final Color palleteColor;

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return          InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius:
          BorderRadius
              .circular(25),
          child: Container(
              height: AppLayout.getHeight(80),
              width: AppLayout.getWidth(90),
              color: palleteColor),
        ));
  }
}
