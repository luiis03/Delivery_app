import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/producto.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  List<Producto> carrito = [
    Producto(nombre: 'Producto 1', cantidad: 2, precio: 10.0),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: carrito.length,
                itemBuilder: (context, index) {
                  Producto producto = carrito[index];
                  return ListTile(

                    title: Text(producto.nombre),
                    subtitle: Text('Cantidad: ${producto.cantidad} - Precio: \$${producto.precio}'),
                    trailing: IconButton(
                      onPressed: () {
                        eliminarDelCarrito();
                      },
                      icon: Icon(Icons.delete_forever_rounded,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text('Total: \$${calcularTotalCarrito()}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para finalizar el pedido
                // Puedes agregar la navegación a la pantalla de confirmación o realizar otras acciones
              },
              child: Text('Finalizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }

  void eliminarDelCarrito() {

  }

  double calcularTotalCarrito() {
    double total = 0.0;
    for (Producto producto in carrito) {
      total += (producto.cantidad * producto.precio);
    }
    return total;
  }
}
