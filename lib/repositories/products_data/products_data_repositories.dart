

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
      final response = await _dio.get(_mainURL ?? "");
      return ProductsDataModel.fromJson(jsonDecode(response.data));
    } catch (err) {
      return ProductsDataModel.withError("Có lỗi xảy ra");
    }
  }
}
