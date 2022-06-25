import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';

class AuthRepository {
  static String? mainUrl = dotenv.env['MAIN_API_URL'];

  var loginUrl = '$mainUrl/api/shoplix/login';
  var registerUrl = '$mainUrl/api/shoplix/register';
  var sendOtpUrl = '$mainUrl/api/shoplix/get-reset-password-otp';
  var checkOTPAndResetPassword =
      '$mainUrl/api/shoplix/check-reset-password-otp-and-reset-password';

  final Dio dio = Dio();

  Future<bool> hasToken() async {
    final token = await secureStorage.readToken();
    return token != null;
  }

  Future<AuthUserResponse?> currentUser() async {
    try {
      final token = await secureStorage.readToken();
      var response = await dio.get(
        "$mainUrl/api/data/shoplix/info",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${token?.accessToken ?? ""}",
          },

        ),
      );
      var authUser = AuthUser.fromJson(response.data['dt']);
      return AuthUserResponse(
        isLoggedIn: true,
        user: authUser,
        isError: false,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        return const AuthUserResponse(
          isLoggedIn: false,
          isError: true,
        );
      }
    } catch (e) {
      return const AuthUserResponse(
        isLoggedIn: false,
        isError: true,
      );
    }
    return const AuthUserResponse();
  }

  Future<ResponseDTO> sendForgotPasswordOTP({required String phone}) async {
    try {
      final response =
          await dio.post(sendOtpUrl, data: jsonEncode({'phone': phone}));
      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('sendPasswordReset: $e');
      return {} as ResponseDTO;
    }
  }

  Future<ResponseDTO> checkForgotPasswordOTPAndResetPassword(
      {required String phone,
      required String otp,
      required String password}) async {
    try {
      var data = jsonEncode({
        'phone': phone,
        'otp': otp,
        'password': password,
      });
      final response = await dio.post(checkOTPAndResetPassword,
          data: data,
          options: Options(headers: {"Content-Type": "application/json"}));
      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('sendPasswordReset: $e');
      return {} as ResponseDTO;
    }
  }

  Future<ResponseDTO> signInWithEmailAndPassword(Login login) async {
    try {
      final response =
          await dio.post(loginUrl, data: jsonEncode(login.toJson()));
      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
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
