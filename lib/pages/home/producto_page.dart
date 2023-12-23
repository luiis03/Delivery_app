import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/producto.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/icon_text_widget.dart';

class ProductoPage extends StatefulWidget {
  final Producto producto;
  const ProductoPage({Key? key, required this.producto}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: AppColors.naranja,
                  expandedHeight: 380.0,
                  floating: false,
                  pinned: true,
                  actions: [
                    Center(
                      child: Badge(
                        // badgeContent: Consumer<CartProvider>(
                        //   builder: (context, value, child) {
                        //     return Text(value.getCounter().toString(),
                        //         style: TextStyle(color: Colors.white));
                        //   },
                        // ),
                        // animationDuration: Duration(milliseconds: 300),
                        // animationType: BadgeAnimationType.slide,
                        child: Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                    SizedBox(width: 20.0)
                  ],
                  actionsIconTheme: IconThemeData(size: 20, color: Colors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    // title: Text(widget.producto.nombre),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(widget.producto.imagen),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: cardInfo(widget.producto),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  // cardCarta(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 30),
                      Text("Recomendados", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  // carrouselProductos(widget.restaurantes),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 30),
                      Text("Todos los productos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  // carrouselProductos(widget.restaurantes),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 0,
            child: cardCarrito(),
          ),
        ],
      ),
    );
  }

  Container cardInfo(Producto producto) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  producto.nombre,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconAndTextWidget(
                  icon: Icons.location_pin,
                  text: producto.nombre,
                  textColor: AppColors.textColor,
                  iconColor: AppColors.iconColor1,
                ),
                IconAndTextWidget(
                  icon: Icons.delivery_dining,
                  text: "Si" ?? '',
                  textColor: AppColors.textColor,
                  iconColor: AppColors.iconColor2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconAndTextWidget(
                  icon: Icons.phone_android_rounded,
                  text: producto.nombre,
                  textColor: AppColors.textColor,
                  iconColor: AppColors.iconColor2,
                ),
                IconAndTextWidget(
                  icon: Icons.timer,
                  text: producto.nombre ?? '',
                  textColor: AppColors.textColor,
                  iconColor: AppColors.iconColor2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox cardCarrito() {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width - 75,
      child: Column(
        children: [
          ListTile(
            tileColor: AppColors.naranja, // Color de fondo del ListTile
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados del ListTile
            ),
            leading: Icon(Icons.shopping_bag_rounded),
            title: Text(
              'Añade comida al carrito',
              style: TextStyle(
                color: Colors.black, // Color del texto
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

}