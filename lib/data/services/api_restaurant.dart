part of 'services.dart';

class ApiRestaurant {
  static Future<ListRestaurantResponse> fetchListRestaurant() async {
    try {
      final response = await dioClient.dio.get('/list');

      log("data : ${response.data}");
      return ListRestaurantResponse.fromJson(response.data);
    } on DioException catch (e) {
      return ListRestaurantResponse(
        count: 0,
        error: true,
        restaurants: [],
        message: e.handleDioException(),
      );
    } catch (e) {
      return ListRestaurantResponse(
        count: 0,
        error: true,
        restaurants: [],
        message: "Something went wrong, please try again later",
      );
    }
  }

  static Future<ListRestaurantResponse> fetchSearchRestaurant({
    required String query,
  }) async {
    try {
      final response = await dioClient.dio.get('/search?q=$query');

      log("data : ${response.data}");
      return ListRestaurantResponse.fromJson(response.data);
    } on DioException catch (e) {
      return ListRestaurantResponse(
        count: 0,
        error: true,
        restaurants: [],
        message: e.handleDioException(),
      );
    } catch (e) {
      return ListRestaurantResponse(
        count: 0,
        error: true,
        restaurants: [],
        message: "Something went wrong, please try again later",
      );
    }
  }

  static Future<DetailRestaurantResponse> fetchDetailRestaurant({
    required String id,
  }) async {
    try {
      final response = await dioClient.dio.get('/detail/$id');

      log("data : ${response.data}");
      return DetailRestaurantResponse.fromJson(response.data);
    } on DioException catch (e) {
      log("error : ${e.message}");
      return DetailRestaurantResponse(
        error: true,
        message: e.handleDioException(),
      );
    } catch (e) {
      log("error : ${e.toString()}");
      return DetailRestaurantResponse(
        error: true,
        message: "Something went wrong, please try again later",
      );
    }
  }

  static Future<AddReviewResponse> addReviewRestaurant({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final response = await dioClient.dio.post(
        '/review',
        data: {'name': name, 'review': review, 'id': id},
      );

      log("data : ${response.data}");
      return AddReviewResponse.fromJson(response.data);
    } on DioException catch (e) {
      return AddReviewResponse(error: true, message: e.handleDioException());
    } catch (e) {
      return AddReviewResponse(
        error: true,
        message: "Something went wrong, please try again later",
      );
    }
  }
}
