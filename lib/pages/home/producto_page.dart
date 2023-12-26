import 'package:delivery_app/pages/home/restaurante_page.dart';
import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';

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
  int cantidadProducto = 1;


  @override
  void initState() {
    super.initState();
    cantidadProducto = 1;
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
                  automaticallyImplyLeading: false,
                  leading: IconButton(onPressed: () => context.pop(), icon: Icon(Icons.arrow_back, color: Colors.white,)),
                  backgroundColor: AppColors.naranja,
                  expandedHeight: 360.0,
                  floating: false,
                  pinned: true,
                  actions: [
                    Center(
                      child: IconBadge(
                        icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        itemCount: 2,
                        badgeColor: Colors.black,
                        itemColor: Colors.white,
                        hideZero: true,
                      ),
                    ),
                    SizedBox(width: 5)
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
            body: Column(
                children: [
                  SizedBox(height: 0.2),
                ]
              ),
          ),
        ],
      ),
    );
  }

  Container cardInfo(Producto producto) {
    return Container(
      height: 440,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 25),
              Text(
                producto.nombre,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            restarCantidad();
                          });
                        },
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            cantidadProducto.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            sumarCantidad();
                          });
                        },
                        icon: Icon(Icons.add_circle_outline_rounded),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 100),
              Column(
                children: [
                  Text(
                    widget.producto.precio.toString() + " €",
                    style: TextStyle(
                      color: AppColors.naranja,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 20),
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
          Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descripción breve",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                            "Aliquam ac suscipit arcu, eu sollicitudin orci. Maecenas varius eleifend quam, vel tempus nunc congue dignissim. "
                            "Nullam velit massa, vehicula eu tempus.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),

              cardCarrito(),
            ],
          ),
        ],
      ),
    );
  }

  Container cardCarrito() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 125,
      decoration: BoxDecoration(
        color: AppColors.naranja,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          addCarrito(cantidadProducto, widget.producto);
        },
        style: ElevatedButton.styleFrom(
          primary: AppColors.naranja,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.shopping_cart_outlined),
          title: Text(
            'Añadir al carrito',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }


  void restarCantidad() {
    if (cantidadProducto > 1) {
      cantidadProducto -= 1;
    }
  }

  void sumarCantidad() {
    cantidadProducto += 1;
  }

  void addCarrito(int cantidadProducto, Producto producto) {

  }

}