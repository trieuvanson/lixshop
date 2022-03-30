import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/models/auth/response_dto.dart';
import 'package:lixshop/models/checkout/checkout_model.dart';

class CheckoutRepository {
  static String? mainUrl = dotenv.env['MAIN_API_URL'];

  final Dio dio = Dio();

  Future<ResponseDTO> confirmCheckout(CheckoutModel checkoutModel) async {
    try {
      print(jsonEncode(checkoutModel.toJson()));

      var authorization =
          "Bearer eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MTU1ODU3LCJzdWIiOiJqYW5lIiwianRpIjoiMjllMDMwYjEtZTNmZi00M2I3LWI5MGUtNjA3ODJhYTA5YWI4IiwiaWF0IjoxNjQ4MDk5NjUzLCJleHAiOjE2NTYwNDg0NTN9.JL7FcJ5Bs6hvQlU8vYpG8sg6EhHDhGYitEgXr_R1ihnUsg1gH5TC0smpJP371neYCf-4Daqb6Mc3QFWXGnODQ8faBx3CXIhUII6Kp7EHyK5EmixQKNWDH_8wUcntpVjPJxCuFq_T8oOZT0u2okYhliFnglm-sOPDL7Ok5q7T6raAz-sf1ijbBoSW5SaKjQ5UTLD5u8Q5Pf85Xz6elXavHmCv-1dFXPpyZlpn6ED8OJ6_g_RPdqu1vDQvJgtsx2147vlXJFzRzdwUDTWcVdHCRWhK1rUDYJZ-Ac5dq7KpEuY4cmUKdq04n3DPMncaVWGaOYB10_VpgIwkO8bIEUKnhw";
      var response = await dio.post(
        "$mainUrl/api/data/donhang/save",
        data: jsonEncode(checkoutModel.toJson()),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": authorization,
          },
        ),
      );
      return ResponseDTO.fromJson(response.data);
    } on DioError catch (e) {
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('error: $e');
      return {} as ResponseDTO;
    }
  }
}

final checkoutRepository = CheckoutRepository();
