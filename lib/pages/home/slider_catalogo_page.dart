import 'dart:convert';

import 'package:delivery_app/pages/home/restaurante_page.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/utils/helper.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon_text_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../api/repository/impl/restaurantes_repository_impl.dart';
import '../../models/restaurantes.dart';
import '../../utils/colors.dart';

class SliderCatalogoPage extends StatefulWidget {
  const SliderCatalogoPage({super.key});

  @override
  _SliderCatalogoPageState createState() => _SliderCatalogoPageState();
}

class _SliderCatalogoPageState extends State<SliderCatalogoPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currentPage = 0.0;
  List<Restaurantes> restaurantes = [];

  @override
  void initState() {
    super.initState();
    cargarRestaurantes();
  }

  Future<void> cargarRestaurantes() async {
    List<Restaurantes> restaurantes = await RestaurantesRepositoryImpl().getRestaurantes();
    setState(() {
      this.restaurantes = restaurantes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.buttonBackgroundColor,
          height: 280,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page.toDouble();
              });
            },
            itemCount: restaurantes.length,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        if (restaurantes.isNotEmpty)
          DotsIndicator(
            dotsCount: restaurantes.length,
            position: _currentPage.toInt(),
            decorator: DotsDecorator(
              activeColor: AppColors.naranja,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
      ],
    );
  }

  Widget _buildPageItem(int position) {
    Restaurantes restaurante = restaurantes[position];
    final double containerHeight1 = 220; // Ajusta según sea necesario
    final double containerHeight2 = 120; // Ajusta según sea necesario

    return Stack(
      children: [
        // Imagen restaurante
        GestureDetector(
          onTap: () => context.push(RestaurantePage(restaurantes: restaurante)),
          child: Container(
            height: containerHeight1,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(restaurante.img_default),
              ),
            ),
          ),
        ),
        // Info restaurante
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: containerHeight2,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        restaurante.nombre,
                        style: TextStyle(
                          fontSize: 18, // Ajusta el tamaño del texto según sea necesario
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 10),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconAndTextWidget(
                        icon: Icons.location_pin,
                        text: restaurante.direccion,
                        textColor: AppColors.textColor,
                        iconColor: AppColors.iconColor1,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(
                        icon: Icons.phone_android_rounded,
                        text: restaurante.telefono,
                        textColor: AppColors.textColor,
                        iconColor: AppColors.iconColor2,
                      ),
                      IconAndTextWidget(
                        icon: Icons.timer,
                        text: restaurante.codigo_postal ?? '',
                        textColor: AppColors.textColor,
                        iconColor: AppColors.iconColor2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}
