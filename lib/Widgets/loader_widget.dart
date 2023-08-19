
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: LoadingAnimationWidget.discreteCircle(color: Colors.redAccent,size: 50,secondRingColor: Colors.amber,thirdRingColor: Colors.lightBlue),
    );
  }
}
