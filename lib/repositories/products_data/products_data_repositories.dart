

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/models.dart';
import 'base_products_data_repository.dart';

class ProductsDataRepositories extends BaseProductsDataRepository {
  static final Dio _dio = Dio();
  static final String? _mainURL = dotenv.env['MAIN_URL'];

  @override
  Future<ProductsDataModel> getProductsData() async {
    try {
      var authorization = "\$2b\$10\$5THjp/hlMQZ3z78tuewOKetKL8Pl/HpVhMl0zDJnSaGvRGFl2zgqi";

      final response = await _dio.get("https://api.jsonbin.io/b/623edb027caf5d6783723c76", options: Options(headers: {
        "secret-key": authorization,
      }));
      return ProductsDataModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    catch (err) {
      print('Error: $err');
      return ProductsDataModel.withError("Có lỗi xảy ra");
    }
  }
}
