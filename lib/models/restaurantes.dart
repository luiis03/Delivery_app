import 'menus.dart';

class Restaurantes {
  final int id;
  final String nombre;
  final String direccion;
  final String ciudad;
  final String provincia;
  final String codigo_postal;
  final String telefono;
  final String horario;
  final Menus menus;

  Restaurantes({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.ciudad,
    required this.provincia,
    required this.codigo_postal,
    required this.telefono,
    required this.horario,
    required this.menus
  });

}