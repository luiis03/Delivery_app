import 'dart:async';

import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    await Future.delayed(const Duration(seconds: 3));
    loadNextScreen();
  }

  void loadNextScreen() {
    context.push(LandingScreen());
    print('SplashScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.amber,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/img/logo_app.png",
              ),
            ),
          ],
        ),
    );
  }
}
