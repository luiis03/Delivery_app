import 'package:delivery_app/models/producto.dart';

class Restaurantes {
  final int id;
  final String nombre;
  final String direccion;
  final String ciudad;
  final String provincia;
  final String codigo_postal;
  final String telefono;
  final String horario;
  final String logo_imagen;
  final String img_default;
  final String tiempo_estimado;
  final List<Producto> productos;

  Restaurantes({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.ciudad,
    required this.provincia,
    required this.codigo_postal,
    required this.telefono,
    required this.horario,
    required this.logo_imagen,
    required this.img_default,
    required this.tiempo_estimado,
    required this.productos
  });

}