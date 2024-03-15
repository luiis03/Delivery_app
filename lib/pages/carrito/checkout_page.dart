import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/producto.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Producto> carrito = [
    Producto(nombre: 'Productoasdaasdasdasdsasdsd 1', cantidad: 2, precio: 10.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.naranja,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.grey[200],
                elevation: 5.0,
                child: Container(
                  height: 500.0,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Mi carrito',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.shopping_cart_outlined)
                        ],
                      ),
                      Divider(
                        height: 15,
                        color: Colors.grey,
                      ),
                      // Lista de productos
                      Container(
                        height: 430.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: carrito.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 80,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: AppColors.naranja,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.fromLTRB(12, 5, 12, 8), // Ajusta los valores según tus preferencias
                                leading: Container(
                                  width: 70, // Ajusta el ancho del leading según tus preferencias
                                  height: 80, // Ajusta la altura del leading según tus preferencias
                                  decoration: BoxDecoration(
                                    color: AppColors.naranja,
                                    borderRadius: BorderRadius.circular(20), // Añade un borde
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/img/hamburguesa_victoria.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  carrito[index].nombre.length > 25 ? carrito[index].nombre.substring(0, 25) + '...' : carrito[index].nombre,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Precio: ${carrito[index].precio}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                trailing: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.black,
                                  child: Text(
                                    carrito[index].cantidad.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: Colors.grey[200],
                elevation: 5.0,
                child: Container(
                  height: 150.0,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total
                      Container(
                        height: 120.0,
                        child: Column(
                          children: [
                            ListTile(
                              tileColor: AppColors.naranja, // Color de fondo del ListTile
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados del ListTile
                              ),
                              title: Center(
                                child: Text(
                                  'Total del Pedido: \$${calcularTotalCarrito()}',
                                  style: TextStyle(
                                    color: Colors.black, // Color del texto
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Botón Terminar pedido
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.naranja, // Color de fondo del botón
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0), // Bordes redondeados del botón// Borde del botón
                                ),
                              ),
                              onPressed: () {
                                // Navegar a la pantalla de finalización del pedido
                              },
                              child: Text('Terminar Pedido',
                                style: TextStyle(
                                  color: Colors.black, // Color del texto
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  void eliminarDelCarrito() {}

  double calcularTotalCarrito() {
    double total = 0.0;
    for (Producto producto in carrito) {
      total += (producto.cantidad * producto.precio);
    }
    return total;
  }

}