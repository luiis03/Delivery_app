import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery_app/api/repository/impl/restaurantes_repository_impl.dart';
import 'package:delivery_app/pages/home/slider_catalogo_page.dart';
import 'package:delivery_app/pages/perfil/perfil_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/sub_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/restaurantes.dart';
import '../../utils/dimensions.dart';
import '../carrito/carrito_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 1;
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBlackColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(text: "Direccion", color: AppColors.mainColor),
              ],
            ),
            customSwitch(),
          ],
        ),
      ),
      bottomNavigationBar: wBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Offstage(child: PerfilPage(), offstage: _currentIndex != 0),
          Offstage(child: HomePage(), offstage: _currentIndex != 1),
          Offstage(child: CarritoPage(), offstage: _currentIndex != 2),
        ],
      ),
    );
  }

  CurvedNavigationBar wBottomNavigationBar() {
    return CurvedNavigationBar(
        height: 55,
        color: AppColors.mainBlackColor,
        backgroundColor: AppColors.mainColor,
        animationCurve: Curves.easeInCubic,
        animationDuration: const Duration(milliseconds: 400),
        items: const <Widget>[
          Icon(Icons.person, size: 30, color: AppColors.mainColor),
          Icon(Icons.home, size: 30, color: AppColors.mainColor),
          Icon(Icons.shopping_cart, size: 30, color: AppColors.mainColor),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        });
  }

  Center customSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_walk,
              color: switchValue ? Colors.grey : AppColors.mainColor),
          CupertinoSwitch(
            activeColor: AppColors.mainColor,
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
          ),
          Icon(Icons.delivery_dining,
              color: switchValue ? AppColors.mainColor : Colors.grey),
        ],
      ),
    );
  }

}
