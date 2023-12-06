import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const routeName = "/splashScreen";
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        child: Stack(
          children: [
            Text("HOLA"),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/img/logo_app.png",
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/img/logo_app.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
