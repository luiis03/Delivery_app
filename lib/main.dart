import 'package:delivery_app/pages/forget_pw_screen.dart';
import 'package:delivery_app/pages/home/home_page.dart';
import 'package:delivery_app/pages/home/main_page.dart';
import 'package:delivery_app/pages/landing_screen.dart';
import 'package:delivery_app/pages/login_screen.dart';
import 'package:delivery_app/pages/signup_screen.dart';
import 'package:delivery_app/pages/splash_screen.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My delivery App',
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: Colors.amber,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColors.naranja,
            ),
            shape: MaterialStateProperty.all(
              StadiumBorder(),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              AppColors.naranja,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: LandingScreen.routeName, page: () => LandingScreen()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: SignUpScreen.routeName, page: () => SignUpScreen()),
        GetPage(name: ForgetPwScreen.routeName, page: () => ForgetPwScreen()),
      ],
    );
  }
}
