import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';

class AuthRepository {
  static String? mainUrl = dotenv.env['MAIN_API_URL'];

  var loginUrl = '$mainUrl/api/shoplix/login';

  final Dio dio = Dio();

  Future<bool> hasToken() async {
    final token = await _getTokenFromFile();
    return token.dt != null;
  }

  // Future<ResponseDTO> login(Login login) async {
  //   try {
  //     final response =
  //         await dio.post(loginUrl, data: jsonEncode(login.toJson()));
  //     return ResponseDTO.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print('DioError: $e');
  //     return ResponseDTO.fromJson(e.response!.data);
  //   }
  // }

  Future<AuthUser> currentUser() async {
    final ResponseDTO responseDTO = await _getTokenFromFile();
    print(responseDTO.dt!.accessToken);
    var response = await dio.get(
      "$mainUrl/api/data/shoplix/info",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${responseDTO.dt!.accessToken}",
        },
      ),
    );
    return AuthUser.fromJson(response.data);
  }

  Future<void> sendPasswordReset({required String phone}) {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }

  Future<ResponseDTO> signInWithEmailAndPassword(Login login) async {
    try {
      final response =
          await dio.post(loginUrl, data: jsonEncode(login.toJson()));
      print('${response.data}');
      _saveTokenToFile(jsonEncode(response.data));
      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('Error: $e');
      return {} as ResponseDTO;
    }
  }
}

@override
Future<void> signOut() async {
  try {
    _deleteTokenFromFile();
  } on DioError catch (e) {
    print('DioError: $e');
  }
}

Future<ResponseDTO> _getTokenFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/token.json');
  return ResponseDTO.fromJson(jsonDecode(await file.readAsString()));
}

Future<void> _saveTokenToFile(String jsonEncode) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/token.json');
  await file.writeAsString(jsonEncode);
}

Future<void> _deleteTokenFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/token.json');
  await file.delete();
}

final authRepository = AuthRepository();
