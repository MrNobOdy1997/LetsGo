import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: LoadingAnimationWidget.flickr(leftDotColor:  Colors.redAccent, rightDotColor: Colors.amber, size: 40)
    );
  }
}