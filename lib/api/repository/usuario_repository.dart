import 'package:delivery_app/models/usuario.dart';

abstract class UsuarioRepository {
  Future<Usuario> getUsuarioById(int id);
}