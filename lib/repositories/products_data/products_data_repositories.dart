import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/models/product/product_brand.dart';
import 'package:lixshop/models/product/products_data.dart';
import 'package:lixshop/repositories/product/base_product_repository.dart';
import 'package:lixshop/repositories/products_data/base_products_data_repository.dart';

class ProductsDataRepositories extends BaseProductsDataRepository {
  static final Dio _dio = Dio();
  static final String? _mainURL = dotenv.env['MAIN_URL'];

  @override
  Future<ProductsData> getProductsData() async {
    try {
      final response = await _dio.get(_mainURL ?? "");
      return ProductsData.fromJson(jsonDecode(response.data));
    } catch (err) {
      return Future.error(err);
    }
  }
}
