
import 'package:delivery_app/api/controller/user_controller.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:delivery_app/models/usuario.dart';
import 'package:delivery_app/pages/carrito/carrito_notifier.dart';
import 'package:delivery_app/utils/user_notifier.dart';

import 'package:delivery_app/pages/splash_screen.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.lazyPut<UserController>(() => UserController());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarritoNotifier()),
        ChangeNotifierProvider(
          create: (context) => UserNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // late ThemeData _themeData = ThemeData.dark();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final carritoNotifier = Provider.of<CarritoNotifier>(context, listen: false);
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
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: AppColors.naranja,
          unselectedItemColor: Colors.white,
        ),
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
      themeMode: ThemeMode.light,
      // onGenerateRoute: AppRouter.onGenerateRoute,
      home: SplashScreen(),
    );


  }
}
