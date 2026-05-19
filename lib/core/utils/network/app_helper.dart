import 'package:dio/dio.dart';

import 'app_endpoint.dart';

class AppHelper {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: AppEndpoint.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // GET METHOD
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Map<String, dynamic> key = {
        'key': '132e3e5ebf3a426dae243643260605',
      };
      queryParameters = {...?queryParameters, ...key};
      final response = await dio.get(path, queryParameters: queryParameters);

      return response;
    } on DioException catch (e) {
      throw Exception(handleError(e));
    }
  }

  String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';

      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';

      case DioExceptionType.badResponse:
        return 'Server error';

      default:
        return 'Something went wrong';
    }
  }
}
