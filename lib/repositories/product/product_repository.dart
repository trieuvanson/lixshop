import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/models.dart';
import '../repositories.dart';
import 'base_product_repository.dart';

class ProductRepositories extends BaseProductRepository {
  final Dio _dio = Dio();
  final String? _mainURL = dotenv.env['MAIN_URL'];

  @override
  Future<ProductBrandModel> getAllProducts() async {
    try {
      final response = await _dio.get(_mainURL ?? "");
      return ProductBrandModel.fromJson(jsonDecode(response.data));
    } catch (e) {
      return ProductBrandModel.withError(e.toString());
    }
  }

  ProductBrandModel getProducts(ProductsDataModel productsDataModel) {
    try {
      ProductCateModel productCateModel =
          ProductCategoryRepository().getAllCategories2(productsDataModel);
      List<ProductBrand> productBrands = [];
      for (var element in productCateModel.productCates!) {
        productBrands.addAll(element.productBrand!);
      }

      return ProductBrandModel(productBrands: productBrands, error: "");
    } catch (err) {
      return ProductBrandModel.withError(err.toString());
    }
  }
}
