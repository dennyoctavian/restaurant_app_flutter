import 'package:flutter/material.dart';
import 'package:restaurant_app/data/interface/i_api_restaurant.dart';
import 'package:restaurant_app/data/models/list_restaurant_response.dart';

class RestaurantListNotifier extends ChangeNotifier {
  final IApiRestaurant apiRestaurant;

  RestaurantListNotifier({required this.apiRestaurant});
  bool _isLoading = false;
  bool _isError = false;
  String _message = '';
  List<Restaurants> _restaurants = [];

  List<Restaurants> get restaurants => _restaurants;
  bool get isError => _isError;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchListRestaurant() async {
    _isLoading = true;
    notifyListeners();

    final result = await apiRestaurant.fetchListRestaurant();

    if (result.error ?? false) {
      _isError = true;
      _message = result.message ?? '';
      _isLoading = false;
      notifyListeners();
    } else {
      _restaurants = result.restaurants ?? [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSearchRestaurant({required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await apiRestaurant.fetchSearchRestaurant(query: query);

    if (result.error ?? false) {
      _isError = true;
      _message = result.message ?? '';
      _isLoading = false;
      notifyListeners();
    } else {
      _restaurants = result.restaurants ?? [];
      _isLoading = false;
      notifyListeners();
    }
  }
}
