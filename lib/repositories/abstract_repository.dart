import 'package:dio/dio.dart';

import '../constants/env.dart';

abstract class AbstractRepository<E, K> {
  final _dio = Dio();
  final String? mainUrl = baseUrl;

  post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
        data: body,
      );
      return response;
    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  get({required String url, String? token}) async {
    try {
      return await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );
    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  put({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      return await _dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
        data: body,
      );
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return e.response;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }

  delete({required String url, dynamic body, String? token}) async {
    try {
      return await _dio.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
        data: body,
      );
    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
