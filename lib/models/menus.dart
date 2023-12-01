import 'platos.dart';

class Menus {
  final int id;
  final String nombre;
  final double precio;
  final List<Platos> platos;

  Menus({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.platos
  });
}