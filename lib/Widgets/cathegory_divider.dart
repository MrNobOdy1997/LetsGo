import 'package:flutter/material.dart';

import 'package:letsgo/Utils/pallete.dart';
import 'package:letsgo/Utils/size_controller.dart';

class CategoryDivider extends StatelessWidget {
  final String title;

  const CategoryDivider({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: heading4,
        ),
        SizedBox(
          height: AppLayout.getHeight(5),
        ),
      ],
    );
  }
}
