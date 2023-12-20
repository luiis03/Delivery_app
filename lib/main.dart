import 'package:delivery_app/firebase_options.dart';
import 'package:delivery_app/pages/forget_pw_screen.dart';
import 'package:delivery_app/pages/landing_screen.dart';
import 'package:delivery_app/pages/login_screen.dart';
import 'package:delivery_app/pages/signup_screen.dart';
import 'package:delivery_app/pages/splash_screen.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery app',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: Colors.amber,
        useMaterial3: false,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.naranja),
            shape: MaterialStateProperty.all(const StadiumBorder()),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.naranja),
        ),
        ),
        ),
      home: SplashScreen(),
    );

  }
}
