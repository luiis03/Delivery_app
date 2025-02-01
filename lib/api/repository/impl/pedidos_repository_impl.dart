import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/pedido.dart';
import '../../../models/producto.dart';
import '../pedidos_repository.dart';

class PedidosRepositoryImpl implements PedidosRepository {
  @override
  Future<List<Pedido>> getPedidosByIdUsuario(int idUsuario) async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Pedido> fetchedPedidos = [];
        for (var pedido in jsonData['pedidos']) {
          List<Producto> productos = (pedido['productos'] as List)
              .map((producto) => Producto(
            id: producto['id'],
            nombre: producto['nombre'],
            precio: producto['precio'],
            cantidad: producto['cantidad'],
            imagen: producto['imagen'],
          )).toList();
          final pedidoCompleto = Pedido(
            id: pedido['id'],
            idUsuario: pedido['idUsuario'],
            idRestaurante: pedido['idRestaurante'],
            precioTotal: pedido['precioTotal'],
            fecha: pedido['fecha'],
            tipoEnvio: TipoEnvio.values.firstWhere(
                  (e) => e.toString().split('.').last == pedido['tipoEnvio'],
              orElse: () => throw Exception('Tipo de envío no reconocido: ${pedido['tipoEnvio']}'),
            ),
            estadoEnvio: EstadoEnvio.values.firstWhere(
                  (e) => e.toString().split('.').last == pedido['estadoEnvio'],
              orElse: () => throw Exception('Estado de envío no reconocido: ${pedido['estadoEnvio']}'),
            ),
            productos: productos,
          );
          fetchedPedidos.add(pedidoCompleto);
        }
        print(fetchedPedidos.length);
        return fetchedPedidos;
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return [];
      }
    } catch (error) {
      print(error);
      print('Error en la solicitud HTTP: $error');
      return [];
    }
  }
}