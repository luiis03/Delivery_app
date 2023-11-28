import 'dart:convert';

import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon_text_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
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


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.mainColor,
          height: Dimensions.pageView,
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
        SizedBox(height: Dimensions.height30)

      ],
    );
  }

  Widget _buildPageItem(int position){
    return Stack(
          children: [
            //Logo restaurante
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.amber,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/img/bar_victoria.jpg"
                      )
                  )
              ),
            ),
            //Info restaurante
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimensions.pageViewTextContainer,
                  margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.width15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 5)
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(5, 0)
                      )
                    ]
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.height20, right: Dimensions.height15, bottom: Dimensions.height10),
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

