import 'package:delivery_app/pages/carrito/carrito_page.dart';
import 'package:delivery_app/pages/home/home_page.dart';
import 'package:delivery_app/pages/home/restaurante_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  // static Route onGenerateRoute(RouteSettings settings) {
  //   print("The Route is: ${settings.name}");
  //
  //   switch (settings.name) {
  //     case '/':
  //       return HomePage.route();
  //     case HomePage.routeName:
  //       return HomePage.route();
  //     case RestaurantePage.routeName:
  //       return RestaurantePage.route();
  //       break;
  //     default:
  //       return _errorRoute();
  //   }
  // }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(appBar: AppBar(title: Text('Error'),),),
        settings: RouteSettings(name: '/')
    );
  }

}