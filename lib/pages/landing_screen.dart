import 'package:flutter/material.dart';
import 'package:clip_shadowx/clip_shadowx.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = "/landingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: Dimensions.screenWidth,
          height: Dimensions.screenHeight,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipShadow(
                  clipper: CustomClipperAppBar(),
                  shadows: [
                    BoxShadow(
                      color: AppColors.textColor,
                      offset: Offset(0, 15),
                      blurRadius: 10,
                    ),
                  ],
                  child: Container(
                    width: double.infinity,
                    height: Dimensions.screenHeight * 0.5,
                    decoration: ShapeDecoration(
                      color: AppColors.naranja,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/img/logo_app.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/logo_app.png",
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: Dimensions.screenHeight * 0.3,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                          "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Text("Login"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                            MaterialStateProperty.all(AppColors.naranja),
                            shape: MaterialStateProperty.all(
                              StadiumBorder(
                                side:
                                BorderSide(color: AppColors.naranja, width: 1.5),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Create an Account"),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}