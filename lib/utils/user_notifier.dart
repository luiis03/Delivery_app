import 'package:flutter/material.dart';
import '../models/usuario.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserNotifier extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario; // Obtener usuario
  bool get isAuthenticated => _usuario != null; // Verificar si está autenticado

  // Establecer el usuario (autenticación)
  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  // Limpiar los datos del usuario (logout)
  void clearUsuario() {
    _usuario = null;
    notifyListeners();
  }

  Future<Usuario> fetchUser(int id) async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        return Usuario.fromJson(json);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      throw Exception('Failed to load user');
    }
  }
}
