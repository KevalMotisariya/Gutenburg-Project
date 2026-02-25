import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inkwell_library/core/error/exception_handler.dart';

class ApiClient {
  static const String baseUrl = "https://gutendex.com";

  final http.Client client;

  ApiClient({required this.client});

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl$endpoint',
      ).replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ExceptionHandler.handleHttpError(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<Map<String, dynamic>> getFromUrl(String url) async {
    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ExceptionHandler.handleHttpError(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
