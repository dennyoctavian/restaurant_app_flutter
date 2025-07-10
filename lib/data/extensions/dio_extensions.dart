import 'package:dio/dio.dart';

extension DioExtensions on DioException {
  String handleDioException() {
    if (response?.data is Map<String, dynamic>) {
      return (response?.data as Map<String, dynamic>)['message'];
    } else if (type == DioExceptionType.cancel) {
      return "Request to API was canceled.";
    } else if (type == DioExceptionType.connectionTimeout) {
      return "Connection timeout occurred.";
    } else if (type == DioExceptionType.sendTimeout) {
      return "Send timeout occurred.";
    } else if (type == DioExceptionType.receiveTimeout) {
      return "Receive timeout occurred.";
    } else if (type == DioExceptionType.badCertificate) {
      return "Bad certificate occurred.";
    } else if (type == DioExceptionType.badResponse) {
      return "Bad response occurred.";
    } else if (type == DioExceptionType.connectionError) {
      return "Connection error occurred.";
    } else if (type == DioExceptionType.unknown) {
      if (response != null) {
        return "API error: ${response?.statusCode} - ${response?.statusMessage ?? 'No status message'}";
      }
      return "Unexpected error: $message";
    } else {
      return "Unexpected error: $message";
    }
  }
}
