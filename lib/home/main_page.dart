import 'dart:convert';

import 'package:delivery_app/home/slider_catalogo_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/sub_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/restaurantes.dart';
import '../utils/dimensions.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  bool switchValue = false;

  List<Restaurantes> restaurantes = [];

  Future getRestaurantes() async {
    var response = await http.get(Uri.https('https://victordiaz74.github.io/delivery-app/api.json'));
    var jsonData = jsonDecode(response.body);

    for(var restaurant in jsonData['data']) {
      final restaurante = Restaurantes(
          id: restaurant['id'],
          nombre: restaurant['nombre'],
          direccion: restaurant['direccion'],
          ciudad: restaurant['ciudad'],
          provincia: restaurant['provincia'],
          codigo_postal: restaurant['codigo_postal'],
          telefono: restaurant['telefono'],
          horario: restaurant['horario'],
          menus: restaurant['menus']
      );
      restaurantes.add(restaurante);
    }
    print(restaurantes);
    print(restaurantes.length);
  }

  @override
  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Barra de búsqueda
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.height10,
                bottom: Dimensions.height10,
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Slider catalogo
            const SliderCatalogoPage(),

            // Lista de restaurantes
            FutureBuilder(
              future: getRestaurantes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurantes.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(restaurantes[index].nombre),
                            subtitle: Text(restaurantes[index].ciudad),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }


  Center customSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_walk, color: switchValue ? Colors.grey : AppColors.mainColor),
          CupertinoSwitch(
            activeColor: AppColors.mainColor,
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
          ),
          Icon(Icons.delivery_dining, color: switchValue ? AppColors.mainColor : Colors.grey),
        ],
      ),
    );
  }

}