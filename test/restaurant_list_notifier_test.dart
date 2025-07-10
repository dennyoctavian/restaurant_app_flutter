import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/models/list_restaurant_response.dart';
import 'package:restaurant_app/presentation/provider/restaurant_list_notifier.dart';

import 'mock/api_restaurant_mock.mocks.dart';

void main() {
  late MockIApiRestaurant mockApi;
  late RestaurantListNotifier provider;

  setUp(() {
    mockApi = MockIApiRestaurant();
    provider = RestaurantListNotifier(apiRestaurant: mockApi);
  });

  test('state awal provider harus didefinisikan', () {
    expect(provider.isLoading, false);
    expect(provider.isError, false);
    expect(provider.message, '');
    expect(provider.restaurants, []);
  });

  test('mengembalikan daftar restoran ketika API berhasil', () async {
    final restaurant = Restaurants(id: '1', name: 'Warung Makan');
    final response = ListRestaurantResponse(
      error: false,
      message: 'success',
      count: 1,
      restaurants: [restaurant],
    );

    when(mockApi.fetchListRestaurant()).thenAnswer((_) async => response);

    await provider.fetchListRestaurant();

    expect(provider.isLoading, false);
    expect(provider.isError, false);
    expect(provider.restaurants.length, 1);
    expect(provider.restaurants.first.name, 'Warung Makan');
  });

  test('mengembalikan kesalahan ketika API gagal', () async {
    final response = ListRestaurantResponse(
      error: true,
      message: 'Gagal memuat data',
      restaurants: [],
    );

    when(mockApi.fetchListRestaurant()).thenAnswer((_) async => response);

    await provider.fetchListRestaurant();

    expect(provider.isLoading, false);
    expect(provider.isError, true);
    expect(provider.message, 'Gagal memuat data');
    expect(provider.restaurants, []);
  });
}
