import 'dart:convert';

import 'package:dio/dio.dart';
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
      print(register.toJson());
      print('response: ${response.data}');

      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      print('DioError: ${e.response!.data}');
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('Error1: $e');
      return {} as ResponseDTO;
    }
  }

  Future<List<String>> loadLocation() async {
    try {
      TokenResponse? tokenResponse = await secureStorage.readToken();

      final response = await dio.get('$mainUrl/api/data/agentlix/agentlixs', options: Options(headers: {
        'Authorization': 'Bearer ${tokenResponse?.accessToken??""}',
      }));
      return (response.data['dt'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } on DioError catch (e) {
      print('DioError: ${e.response!.data}');
      return [];
    } catch (e) {
      print('Error1: $e');
      return [];
    }
  }




}

final userRepository = UserRepository();
