import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/models/product/product_brand.dart';
import 'package:lixshop/models/product/products_data.dart';
import 'package:lixshop/repositories/product/base_product_repository.dart';

class ProductRepositories extends BaseProductRepository {
  final Dio _dio = Dio();
  final String? _mainURL = dotenv.env['MAIN_URL'];
  @override
  Future<ProductBrandModel> getAllProducts() async {
    try {
      final response = await _dio.get(_mainURL ?? "");

      // ProductsData productsData =
      //     ProductsData.fromJson(jsonDecode(response.data));
      // List<ProductCate> productCate =
      //     productsData.productCate!.map((e) => e).toList();
      // List<ProductBrand> productBrands = [];
      //
      // for (var element in productCate) {
      //   for (var element in element.productBrand!) {
      //     productBrands.add(element);
      //   }
      // }
      //
      // return productBrands;
      return ProductBrandModel.fromJson(jsonDecode(response.data));
    } catch (e) {
      return ProductBrandModel.withError(e.toString());
    }
  }
}
