import 'package:delivery_app/models/producto.dart';
import 'package:flutter/foundation.dart';

class CarritoNotifier extends ChangeNotifier {
  List<Producto> carrito = [
    Producto(nombre: 'Productoasdaasdasdasdsasdsd 1', cantidad: 2, precio: 10.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
    Producto(nombre: 'Producto 2', cantidad: 1, precio: 15.0, id: 1, imagen: "assets/img/hamburguesa_victoria.jpeg"),
  ];

  void agregarAlCarrito(Producto producto) {
    carrito.add(producto);
    notifyListeners();
  }

  void quitarDelCarrito(Producto producto) {
    carrito.remove(producto);
    notifyListeners();
  }
}
