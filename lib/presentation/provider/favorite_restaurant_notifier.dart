import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/detail_restaurant_response.dart';
import 'package:restaurant_app/data/services/services.dart';

class FavoriteRestaurantNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;
  String _message = '';
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;
  bool get isError => _isError;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchListFavoriteRestaurant() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await LocalFavoriteDbHelper().getFavorites();
      _restaurants = result;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isError = true;
      _message = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
