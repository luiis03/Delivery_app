import 'dart:convert';

import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon_text_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/restaurantes.dart';
import '../utils/colors.dart';

class SliderCatalogoPage extends StatefulWidget {
  const SliderCatalogoPage({super.key});

  @override
  _SliderCatalogoPageState createState() => _SliderCatalogoPageState();
}

class _SliderCatalogoPageState extends State<SliderCatalogoPage> {
  PageController pageController = PageController(viewportFraction: 1.0);
  double _currentPage = 0.0;

  List<Restaurantes> restaurantes = [];

  Future<List<Restaurantes>> getRestaurantes() async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Restaurantes> fetchedRestaurantes = [];
        for (var restaurant in jsonData['restaurantes']) {
          final restaurante = Restaurantes(
            id: restaurant['id'],
            nombre: restaurant['nombre'],
            direccion: restaurant['direccion'],
            ciudad: restaurant['ciudad'],
            provincia: restaurant['provincia'],
            codigo_postal: restaurant['codigo_postal'],
            telefono: restaurant['telefono'],
            horario: restaurant['horario'],
            logo_imagen: restaurant['logo_imagen'],
            img_default: restaurant['img_default'],
            menus: restaurant['menus'],
          );
          fetchedRestaurantes.add(restaurante);
        }
        print(fetchedRestaurantes.length);
        return fetchedRestaurantes;
      } else {
        // Manejar el error de manera más explícita y devolver una lista vacía
        print('Error en la solicitud HTTP: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return [];
      }
    } catch (error) {
      // Manejar errores de manera general y devolver una lista vacía
      print(error);
      print('Error en la solicitud HTTP: $error');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.mainBlackColor,
          height: 280,
          child: PageView.builder(
            //para reducir el tamaño del contenedor y poder ver el resto del slider
              controller: PageController(viewportFraction: 0.85),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page.toDouble();
                });
              },
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
          ),
        DotsIndicator(
          dotsCount: 5,
          position: _currentPage.toInt(),
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int position){
    return Stack(
          children: [
            //Logo restaurante
            Container(
              height: Get.context!.height/4.13,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/img/hamburguesa_victoria.jpeg"
                      )
                  )
              ),
            ),
            //Info restaurante
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Get.context!.height/7.23,
                  margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.height20, right: Dimensions.height20, bottom: Dimensions.height10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(text: "Bar Victoria")
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconAndTextWidget(icon: Icons.location_pin, text: "Calle Jacinto Benavente, 13", textColor: AppColors.textColor, iconColor: AppColors.iconColor1)
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndTextWidget(icon: Icons.phone_android_rounded, text: "650 324 508", textColor: AppColors.textColor, iconColor: AppColors.iconColor2),
                            IconAndTextWidget(icon: Icons.timer, text: "45min", textColor: AppColors.textColor, iconColor: AppColors.iconColor2)
                          ],
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        );
  }
}

