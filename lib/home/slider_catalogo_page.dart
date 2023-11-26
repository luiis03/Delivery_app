import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SliderCatalogoPage extends StatefulWidget {
  const SliderCatalogoPage({super.key});

  @override
  _SliderCatalogoPageState createState() => _SliderCatalogoPageState();
}

class _SliderCatalogoPageState extends State<SliderCatalogoPage> {
  PageController pageController = PageController(viewportFraction: 1.0);
  double _currentPage = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 220;

  @override
  void initState() {
    super.initState();
    //manejamos el currentPage con un escuchador para ver en que porcentaje esta dentro de la pagina al cambiar de uno a otro
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
        print("Current page" + _currentPage.toString());
      });
    });
  }

  // @override
  // void dispose() {
  //   //para eliminar de la memoria cosas que no necesitamos almacenar
  //   pageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.iconColor2,
      height: 320,
      child: PageView.builder(
        //para reducir el tamaño del contenedor y poder ver el resto del slider
          controller: PageController(viewportFraction: 0.85),
          itemCount: 5,
          itemBuilder: (context, position) {
        return _buildPageItem(position);
      }),
    );
  }

  Widget _buildPageItem(int position){
    Matrix4 matrix = escalarSlider(position);

    return Transform(
        transform: matrix,
        child: Stack(
          children: [
            //Logo restaurante
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                  height: 120,
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 15, bottom: 10),
                    child: Column(
                      children: [
                        BigText(text: "Bar Victoria"),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconAndTextWidget(icon: Icons.location_pin, text: "Calle Jacinto Benavente, 13", textColor: AppColors.textColor, iconColor: AppColors.iconColor1)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconAndTextWidget(icon: Icons.phone_android_rounded, text: "650 324 508", textColor: AppColors.textColor, iconColor: AppColors.iconColor2),
                            SizedBox(width: 50),
                            IconAndTextWidget(icon: Icons.timer, text: "45min", textColor: AppColors.textColor, iconColor: AppColors.iconColor2)
                          ],
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        )
    );
  }

  Matrix4 escalarSlider(int position) {

    Matrix4 matrix = new Matrix4.identity();
    if(position == _currentPage.floor()) {
      var currentScale = 1 - (_currentPage - position) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransformation, 0);
    } else if(position == _currentPage.floor() + 1) {
      var currentScale = _scaleFactor + (_currentPage - position + 1) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransformation, 0);
    } else if(position == _currentPage.floor() - 1) {
      var currentScale = 1 - (_currentPage - position) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransformation, 0);
    }
    return matrix;
  }
}

