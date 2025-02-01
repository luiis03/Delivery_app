import 'package:delivery_app/models/producto.dart';

class Pedido{
  final int id;
  final int idUsuario;
  final int idRestaurante;
  final double precioTotal;
  final String fecha;
  final TipoEnvio tipoEnvio;
  final EstadoEnvio estadoEnvio;
  final List<Producto> productos;

  Pedido({
    required this.id,
    required this.idUsuario,
    required this.idRestaurante,
    required this.precioTotal,
    required this.fecha,
    required this.tipoEnvio,
    required this.estadoEnvio,
    required this.productos
  });
}

enum TipoEnvio {
  RECOGER,
  A_DOMICILIO
}

enum EstadoEnvio {
  CONFIRMADO,
  CONFIRMADO_RESTAURANTE,
  EN_PREPARACION,
  LISTO,
  EN_REPARTO,
  ENTREGADO,
  PAGADO,
  FINALIZADO
}