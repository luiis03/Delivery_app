

import 'package:delivery_app/models/restaurantes.dart';

abstract class RestaurantesRepository {
  Future<List<Restaurantes>> getRestaurantes();
}