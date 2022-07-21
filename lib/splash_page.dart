import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:show_your_month/root.dart';

class splash_page extends StatelessWidget {
  const splash_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      duration: 2500,
      splash: Container(
        width: 200,
        height: 200,
        child: Image.asset('assets/splash_logo.png'),
      ),
      nextScreen: root(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.white,
    ));
  }
}
