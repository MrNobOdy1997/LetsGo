import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../Controllers/firebase_controller.dart';
import '../../Utils/Constants.dart';
import '../../Utils/size_controller.dart';
import '../BottomNavigationBar/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    await firebaseInitialization
        .then((value) => {Get.put(FirebaseController(), permanent: true)});

    Get.offAll(BottomBar());
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 135,
              height: 135,
              margin: EdgeInsets.only(right: AppLayout.getHeight(20)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/letsgo.png"))),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: AppLayout.getHeight(90),
              width: AppLayout.getWidth(90),
              child: SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: 100,
                appearance: CircularSliderAppearance(
                  infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                    color: Colors.brown.shade400,
                    fontSize: 20,
                  )),
                  customColors: CustomSliderColors(
                      dotColor: Colors.amber,
                      progressBarColor: Colors.redAccent,
                      shadowColor: Colors.lightGreen.shade600,
                      shadowMaxOpacity: 5,
                      trackColor: Colors.lightBlue),
                  customWidths: CustomSliderWidths(
                      trackWidth: 3,
                      progressBarWidth: 8,
                      handlerSize: 8,
                      shadowWidth: 5),
                  spinnerDuration: 1,
                  animDurationMultiplier: 1,
                  animationEnabled: true,
                  startAngle: 0.0,
                  angleRange: 360,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Loading app...',
              style: TextStyle(color: Colors.brown.shade400, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
