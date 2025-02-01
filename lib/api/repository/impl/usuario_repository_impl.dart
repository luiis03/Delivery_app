import 'dart:convert';
import 'package:delivery_app/api/repository/usuario_repository.dart';
import 'package:delivery_app/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioRepositoryImpl implements UsuarioRepository {

  @override
  Future<Usuario> getUsuarioById(int id) async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var usuarioApi = jsonData['usuarios'].firstWhere(
              (usuario) => usuario['id'] == id,
          orElse: () => null,
        );

        // Si el usuario no existe, retornamos null o una excepción
        if (usuarioApi == null) {
          throw Exception('Usuario no encontrado');
        }
        // Crear el objeto Usuario y devolverlo
        final usuario = Usuario(
          id: usuarioApi['id'],
          nombre: usuarioApi['nombre'],
          apellidos: usuarioApi['apellidos'],
          direccion: usuarioApi['direccion'],
          email: usuarioApi['email'],
        );
        return usuario;
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        throw Exception('Error en la solicitud HTTP');
      }
    } catch (error) {
      print('Error en la solicitud HTTP: $error');
      throw Exception('Error en la solicitud HTTP: $error');
    }
  }
}