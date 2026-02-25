import 'dart:io';
import 'package:http/http.dart' as http;
import 'failures.dart';

class ExceptionHandler {
  static Failure handleException(dynamic error) {
    if (error is SocketException) {
      return NetworkFailure("No Internet connection");
    } else if (error is Failure) {
      return error;
    } else {
      return ServerFailure("Unexpected error occurred");
    }
  }

  static Failure handleHttpError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        return ServerFailure("Bad Request");
      case 401:
        return ServerFailure("Unauthorized");
      case 404:
        return ServerFailure("Resource not found");
      case 500:
        return ServerFailure("Internal Server Error");
      default:
        return ServerFailure(
          "Error occurred with code: ${response.statusCode}",
        );
    }
  }
}
