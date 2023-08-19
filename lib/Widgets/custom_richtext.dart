import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Utils/pallete.dart';

class CustomRichText extends StatelessWidget {
  final String discription;
  final String text;
  final Function() onTap;

  const CustomRichText(
      {Key? key,
      required this.discription,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.149,
          top: MediaQuery.of(context).size.height * 0.08),
      child: Text.rich(
        TextSpan(
            text: discription,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            children: [
              TextSpan(
                  text: text,
                  style: const TextStyle(
                      color: kBlue, fontSize: 16, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = onTap),
            ]),
      ),
    );
  }
}
