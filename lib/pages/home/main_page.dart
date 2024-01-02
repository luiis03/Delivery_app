import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery_app/pages/perfil/perfil_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icon_badge/icon_badge.dart';
import 'package:provider/provider.dart';

import '../carrito/carrito_notifier.dart';
import '../carrito/carrito_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({Key? key, this.index = 1}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 1;
  bool switchValue = false;
  String selectedAddress = "Dirección 1";

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final CarritoNotifier carritoNotifier = Provider.of<CarritoNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.buttonBackgroundColor,
        shadowColor: AppColors.buttonBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.location_on, size: 16, color: AppColors.naranja),
            Expanded(child: PopupMenuButton<String>(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    selectedAddress.length > 15 ? selectedAddress.substring(0, 15) + '...' : selectedAddress,
                    style: TextStyle(
                        color: AppColors.naranja,
                        fontSize: 17
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_rounded, size: 25, color: AppColors.naranja),
                ],
              ),
              onSelected: (String result) {
                setState(() {
                  selectedAddress = result;
                });
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: "Dirección 1",
                  child: Row(
                    children: [
                      Text("Dirección 1"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "Dirección 2",
                  child: Row(
                    children: [
                      Text("Dirección 2"),
                    ],
                  ),
                ),
              ],
            )),
            customSwitch(),
          ],
        )
      ),
      bottomNavigationBar: wBottomNavigationBar(carritoNotifier),
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

  CurvedNavigationBar wBottomNavigationBar(CarritoNotifier carritoNotifier) {
    return CurvedNavigationBar(
      height: 55,
      color: AppColors.buttonBackgroundColor,
      backgroundColor: AppColors.naranja,
      animationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 400),
      items: <Widget>[
        Icon(Icons.person, size: 30, color: AppColors.naranja),
        Icon(Icons.home, size: 30, color: AppColors.naranja),
        IconBadge(
          icon: Icon(Icons.shopping_cart, color: AppColors.naranja),
          itemCount: carritoNotifier.carrito.length,
          badgeColor: Colors.black,
          itemColor: Colors.white,
          hideZero: true,
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      index: _currentIndex,
    );
  }


  Center customSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.directions_walk,
              color: switchValue ? Colors.grey : AppColors.naranja
          ),
          CupertinoSwitch(
            activeColor: AppColors.naranja,
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
          ),
          Icon(
              Icons.delivery_dining,
              color: switchValue ? AppColors.naranja : Colors.grey
          ),
        ],
      ),
    );
  }

}
