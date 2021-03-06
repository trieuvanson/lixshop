import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/constants/env.dart';
import 'package:lixshop/models/auth/response_dto.dart';
import 'package:lixshop/models/checkout/checkout_model.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';

class CheckoutRepository {

  final Dio dio = Dio();

  Future<ResponseDTO> confirmCheckout(CheckoutModel checkoutModel) async {
    try {
      // print(jsonEncode(checkoutModel.toJson()));



      var authorization = await secureStorage.readToken();


      var response = await dio.post(
        "$baseUrl/api/data/donhang/save",
        data: jsonEncode(checkoutModel.toJson()),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${authorization!.accessToken}",
          },
        ),
      );
      return ResponseDTO(err: 0, msg: response.data['msg']);
    } on DioError catch (e) {
      return ResponseDTO.fromJson(e.response!.data);
    } catch (e) {
      print('error: $e');
      return {} as ResponseDTO;
    }
  }
}

final checkoutRepository = CheckoutRepository();
