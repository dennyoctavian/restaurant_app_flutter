import 'package:restaurant_app/data/models/list_restaurant_response.dart';

abstract class IApiRestaurant {
  Future<ListRestaurantResponse> fetchListRestaurant();
  Future<ListRestaurantResponse> fetchSearchRestaurant({required String query});
}
