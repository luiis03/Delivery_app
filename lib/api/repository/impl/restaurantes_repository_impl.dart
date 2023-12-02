import 'dart:convert';

import 'package:delivery_app/api/repository/restaurantes_repository.dart';
import 'package:delivery_app/models/restaurantes.dart';
import 'package:http/http.dart' as http;

class RestaurantesRepositoryImpl implements RestaurantesRepository {
  @override
  Future<List<Restaurantes>> getRestaurantes() async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Restaurantes> fetchedRestaurantes = [];
        for (var restaurant in jsonData['restaurantes']) {
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
            menus: restaurant['menus'],
          );
          fetchedRestaurantes.add(restaurante);
        }
        print(fetchedRestaurantes.length);
        return fetchedRestaurantes;
      } else {
        // Manejar el error de manera más explícita y devolver una lista vacía
        print('Error en la solicitud HTTP: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return [];
      }
    } catch (error) {
      // Manejar errores de manera general y devolver una lista vacía
      print(error);
      print('Error en la solicitud HTTP: $error');
      return [];
    }
  }
}