import '../../pages/perfil/perfil_page.dart';

abstract class PerfilRepository {
  Future<void> guardarTema(Tema temaSeleccionado);
}