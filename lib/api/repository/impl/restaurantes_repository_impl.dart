import 'dart:convert';

import 'package:delivery_app/api/repository/restaurantes_repository.dart';
import 'package:delivery_app/models/restaurantes.dart';
import 'package:http/http.dart' as http;

import '../../../models/producto.dart';

class RestaurantesRepositoryImpl implements RestaurantesRepository {
  @override
  Future<List<Restaurantes>> getRestaurantes() async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Restaurantes> fetchedRestaurantes = [];
        for (var restaurant in jsonData['restaurantes']) {
          List<Producto> productos = (restaurant['productos'] as List)
              .map((producto) => Producto(
            id: producto['id'],
            nombre: producto['nombre'],
            precio: producto['precio'],
            cantidad: producto['cantidad'],
            imagen: producto['imagen'],
          )).toList();
          final restaurante = Restaurantes(
            id: restaurant['id'],
            nombre: restaurant['nombre'],
            direccion: restaurant['direccion'],
            ciudad: restaurant['ciudad'],
            provincia: restaurant['provincia'],
            codigo_postal: restaurant['codigo_postal'],
            telefono: restaurant['telefono'],
            horario: restaurant['horario'],
            logo_imagen: restaurant['logo_imagen'],
            img_default: restaurant['img_default'],
            tiempo_estimado: restaurant['tiempo_estimado'],
            productos: productos,
          );
          fetchedRestaurantes.add(restaurante);
        }
        print(fetchedRestaurantes.length);
        return fetchedRestaurantes;
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