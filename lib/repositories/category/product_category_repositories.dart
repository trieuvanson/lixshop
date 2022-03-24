

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/models.dart';
import 'base_category_repository.dart';

class ProductCategoryRepository extends BaseCategoryRepository {
  final Dio _dio = Dio();
  final String? _mainURL = dotenv.env['MAIN_URL'];

  // Future<List<ProductBrand>> getAllProducts() async {
  //   try {
  //     final response = await _dio.get(_mainURL ?? "");
  //     ProductsData productsData =
  //         ProductsData.fromJson(jsonDecode(response.data));
  //     List<ProductCate> productCate = [];
  //     List<ProductBrand> productBrands = [];
  //
  //     ProductsDataRepositories().getProductsData().then((value) => {
  //         productCate = productsData.productCate!.map((e) => e).toList(),
  //
  //     });
  //
  //     for (var element in productCate) {
  //       for (var element in element.productBrand!) {
  //         productBrands.add(element);
  //       }
  //     }
  //
  //     return productBrands;
  //   } catch (err) {
  //     return Future.error(err);
  //   }
  // }

  @override
  Future<ProductCateModel> getAllCategories() async {
    try {
      final response = await _dio.get(_mainURL ?? "");
      return ProductCateModel.fromJson(jsonDecode(response.data));
    } catch (err) {
      return ProductCateModel.withError(err.toString());
    }
  }

  ProductCateModel getAllCategories2(ProductsDataModel productsDataModel) {
    try {
      return ProductCateModel(productCates: productsDataModel.data?.productCate, error: "");
    } catch (err) {
      return ProductCateModel.withError(err.toString());
    }
  }
}
