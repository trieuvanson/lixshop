import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';

import '../../models/models.dart';

class UserRepository {
  final dio = Dio();
  static String? mainUrl = dotenv.env['MAIN_API_URL'];

  var registerUrl = '$mainUrl/api/shoplix/register';

  Future<ResponseDTO> register(Register register) async {
    try {
      final response =
          await dio.post(registerUrl, data: jsonEncode(register.toJson()));
      if (kDebugMode) {
        print(register.toJson());
      }
      if (kDebugMode) {
        print('response: ${response.data}');
      }

      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print('DioError: ${e.response!.data}');
      }
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error1: $e');
      }
      return {} as ResponseDTO;
    }
  }

  Future<List<String>> loadLocation() async {
    try {
      TokenResponse? tokenResponse = await secureStorage.readToken();

      final response = await dio.get('$mainUrl/api/data/agentlix/agentlixs',
          options: Options(headers: {
            'Authorization': 'Bearer ${tokenResponse?.accessToken ?? ""}',
          }));
      if (response.data['err'] != 0) {
        throw Exception(response.data['msg']);
      }
      return (response.data['dt'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } on DioError catch (e) {
      if (kDebugMode) {
        print('DioError: ${e.response!.data}');
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('Error1: $e');
      }
      return [];
    }
  }

  disableUser(String password) async {
    try {
      TokenResponse? tokenResponse = await secureStorage.readToken();

      final response = await dio.put('$mainUrl/api/data/shoplix/disable-shoplix',
          data: jsonEncode({
            'pass': password,
          }),
          options: Options(headers: {
            'Authorization': 'Bearer ${tokenResponse?.accessToken ?? ""}',
          }));
      return {
        'err': response.data['err'],
        'msg': response.data['msg'],
      };
    } on DioError catch (e) {
      if (kDebugMode) {
        print('DioError: ${e.response!.data}');
      }
      return "Lỗi hệ thống, vui lòng thử lại sau!";
    } catch (e) {
      if (kDebugMode) {
        print('Error111: $e');
      }
      return "Đã có lỗi xảy ra, vui lòng thử lại sau!";
    }
  }
}

final userRepository = UserRepository();
