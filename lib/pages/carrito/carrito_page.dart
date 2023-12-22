import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/producto.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  List<Producto> carrito = [
    Producto(nombre: 'Productoasdaasdasdasdsasdsd 1', cantidad: 2, precio: 10.0),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                contentPadding: EdgeInsets.all(3), // Ajusta el espacio interno del ListTile
                                leading: Container(
                                  width: 70, // Ajusta el ancho del leading según tus preferencias
                                  height: 80, // Ajusta la altura del leading según tus preferencias
                                  decoration: BoxDecoration(
                                    color: AppColors.naranja,
                                    borderRadius: BorderRadius.circular(Dimensions.radius20), // Añade un borde
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    child: Image.asset(
                                      "assets/img/hamburguesa_victoria.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  carrito[index].nombre.length > 20 ? carrito[index].nombre.substring(0, 15) + '...' : carrito[index].nombre,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Precio: ${carrito[index].precio}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Lógica para restar uno a la cantidad
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                    Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border: Border.all(color: Colors.black),
                                        color: Colors.black,
                                      ),
                                      child: TextFormField(
                                        initialValue: '1', // Puedes inicializarlo con la cantidad actual
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          backgroundColor: Colors.black,
                                          color: Colors.white,
                                          decoration: TextDecoration.none, // Elimina la línea de debajo del texto
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Lógica para sumar uno a la cantidad
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
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
              SizedBox(height: 25),
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
