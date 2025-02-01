import '../../models/pedido.dart';

abstract class PedidosRepository {
  Future<List<Pedido>> getPedidosByIdUsuario(int idUsuario);
}