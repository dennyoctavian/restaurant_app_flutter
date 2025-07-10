import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/detail_restaurant_response.dart';
import 'package:restaurant_app/data/services/services.dart';

class DetailRestaurantNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;
  String _message = '';
  Restaurant? _restaurant;
  bool _isFavorite = false;

  Restaurant? get restaurant => _restaurant;
  bool get isError => _isError;
  bool get isLoading => _isLoading;
  String get message => _message;
  bool get isFavorite => _isFavorite;

  Future<void> fetchDetailRestaurant({required String id}) async {
    _isLoading = true;
    notifyListeners();

    final result = await ApiRestaurant.fetchDetailRestaurant(id: id);

    if (result.error ?? false) {
      _isError = true;
      _message = result.message ?? '';
      _isLoading = false;
      notifyListeners();
    } else {
      _isFavorite = await LocalFavoriteDbHelper().isFavorite(id);
      _restaurant = result.restaurant;
      _isLoading = false;
      notifyListeners();
    }
  }
}
