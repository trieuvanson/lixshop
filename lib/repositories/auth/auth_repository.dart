import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';

class AuthRepository {
  static String? mainUrl = dotenv.env['MAIN_API_URL'];

  var loginUrl = '$mainUrl/api/shoplix/login';
  var registerUrl = '$mainUrl/api/shoplix/register';

  final Dio dio = Dio();

  Future<bool> hasToken() async {
    final token = await secureStorage.readToken();
    return token != null;
  }

  Future<AuthUser?> currentUser() async {
    try {
      final token = await secureStorage.readToken();
      print('token: $token');
      var response = await dio.get(
        "$mainUrl/api/data/shoplix/info",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${token?.accessToken?? ""}",
          },
        ),
      );
      print('response: ${response.data}');
      print(AuthUser.fromJson(response.data['dt']));
      return AuthUser.fromJson(response.data['dt']);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendPasswordReset({required String phone}) {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }

  Future<ResponseDTO> signInWithEmailAndPassword(Login login) async {
    try {
      final response =
          await dio.post(loginUrl, data: jsonEncode(login.toJson()));
      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      print('DioError: ${e.response!.data}');
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('Error1: $e');
      return {} as ResponseDTO;
    }
  }


  Future<void> signOut() async {
    try {
      await secureStorage.deleteSecureStorage();
    } on DioError catch (e) {
      print('DioError: $e');
    }
  }

}


// Future<ResponseDTO> _getTokenFromFile() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/token.json');
//   return ResponseDTO.fromJson(jsonDecode(await file.readAsString()));
// }
//
// Future<void> _saveTokenToFile(String jsonEncode) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/token.json');
//   await file.writeAsString(jsonEncode);
// }
//
// Future<void> _deleteTokenFromFile() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/token.json');
//   await file.delete();
// }

final authRepository = AuthRepository();
