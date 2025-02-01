import 'package:get/get.dart';
import '../../models/usuario.dart';

class UserController extends GetxController {
  var usuario = Rx<Usuario?>(null);

  // Establecer datos del usuario
  void setUsuario(Usuario newUsuario) {
    usuario.value = newUsuario;
  }

  // Limpiar los datos del usuario (logout)
  void clearUsuario() {
    usuario.value = null;
  }

  // Verificar si el usuario está autenticado
  bool get isAuthenticated => usuario.value != null;
}
