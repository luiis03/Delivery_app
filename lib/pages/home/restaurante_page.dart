import 'package:delivery_app/models/restaurantes.dart';
import 'package:delivery_app/pages/home/producto_page.dart';
import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';

import '../../api/repository/impl/restaurantes_repository_impl.dart';
import '../../models/producto.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/icon_text_widget.dart';
import 'main_page.dart';

class RestaurantePage extends StatefulWidget {
  final Restaurantes restaurantes;
  const RestaurantePage({Key? key, required this.restaurantes}) : super(key: key);

  @override
  _RestaurantePageState createState() => _RestaurantePageState();
}

class _RestaurantePageState extends State<RestaurantePage> {
  late Restaurantes restaurante;

  @override
  void initState() {
    super.initState();
    restaurante = widget.restaurantes;
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
                  expandedHeight: 180.0,
                  floating: false,
                  pinned: true,
                  actions: [
                    Center(
                      child: IconBadge(
                        icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
                        itemCount: 2,
                        badgeColor: Colors.black,
                        itemColor: Colors.white,
                        hideZero: true,
                      ),
                    ),
                    SizedBox(width: 5)
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.restaurantes.nombre),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(widget.restaurantes.logo_imagen),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: cardInfo(widget.restaurantes),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  cardCarta(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 30),
                      Text("Recomendados", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  carrouselProductos(widget.restaurantes),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 30),
                      Text("Todos los productos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  carrouselProductos(widget.restaurantes),
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

  Container cardRestaurante(Restaurantes restaurante) {
    return Container(
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(restaurante.logo_imagen),
        ),
      ),
    );
  }

  Container cardInfo(Restaurantes restaurante) {
    return Container(
      height: 80,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconAndTextWidget(
                  icon: Icons.location_pin,
                  text: restaurante.direccion,
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
    );
  }

  Stack cardProducto(Producto producto) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            // Navegar a la página ProductoPage y enviar la información del producto
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductoPage(producto: producto),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                producto.imagen,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 90,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.naranja,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(producto.nombre, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        Text('\$${producto.precio}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.add_shopping_cart_rounded))),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox carrouselProductos(Restaurantes restaurantes) {
    return SizedBox(
      height: 165,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: restaurantes.productos.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: cardProducto(restaurantes.productos[index])
          );
        }
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
            leading: Icon(Icons.shopping_cart_outlined),
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

  SizedBox cardCarta() {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width - 205,
      child: Column(
        children: [
          ListTile(
            tileColor: AppColors.naranja, // Color de fondo del ListTile
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados del ListTile
            ),
            leading: Icon(Icons.menu_book),
            title: Text(
              'Ver carta',
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