import 'package:restaurant_app/data/models/detail_restaurant_response.dart';

extension RestaurantDbExtension on Restaurant {
  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'pictureId': pictureId,
      'rating': rating,
    };
  }

  static Restaurant fromDbMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      pictureId: map['pictureId'],
      rating: map['rating'] is double
          ? map['rating']
          : double.tryParse(map['rating'].toString()),
    );
  }
}
