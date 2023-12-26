import 'package:shared_preferences/shared_preferences.dart';

import '../../../pages/perfil/perfil_page.dart';
import '../perfil_repository.dart';

class PerfilRepositoryImpl implements PerfilRepository{

  @override
  Future<void> guardarTema(Tema temaSeleccionado) async {
    String tema = temaSeleccionado.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Tema', tema);
  }

}