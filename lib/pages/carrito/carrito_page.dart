import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/producto.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'carrito_notifier.dart';
import 'checkout_page.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {


  @override
  Widget build(BuildContext context) {
    final carritoNotifier = Provider.of<CarritoNotifier>(context);
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
                          itemCount: carritoNotifier.carrito.length,
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
                                contentPadding: EdgeInsets.fromLTRB(10,5,5,5),
                                  /*
                                  contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 5), // Ajusta el espacio interno del ListTile
                                
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
                                      carritoNotifier.carrito[index].imagen,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),*/
                                title: Text(
                                  carritoNotifier.carrito[index].nombre.length > 25 ? carritoNotifier.carrito[index].nombre.substring(0, 25) + '...' : carritoNotifier.carrito[index].nombre,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Precio: ${carritoNotifier.carrito[index].precio}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 130, // Ancho fijo para el trailing
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            carritoNotifier.quitarDelCarrito(carritoNotifier.carrito[index]);
                                          });
                                        },
                                        icon: Icon(Icons.remove_circle_outline),
                                      ), // Ajusta el espacio entre los botones y el CircleAvatar
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.black,
                                        child: Text(
                                          carritoNotifier.carrito[index].cantidad.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ), // Ajusta el espacio entre el CircleAvatar y el botón de añadir
                                      IconButton(
                                        onPressed: () {
                                          carritoNotifier.agregarAlCarrito(carritoNotifier.carrito[index]);
                                        },
                                        icon: Icon(Icons.add_circle_outline),
                                      ),
                                    ],
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
              SizedBox(height: 12),
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
                                context.push(CheckoutPage());
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
    double total = 9.0;
    // for (Producto producto in carrito) {
    //   total += (producto.cantidad * producto.precio);
    // }
    return total;
  }

  void restarCantidad(int cantidadProducto) {
    if (cantidadProducto > 1) {
      cantidadProducto -= 1;
    }
  }

  void sumarCantidad(int cantidadProducto) {
    cantidadProducto += 1;
  }
}
