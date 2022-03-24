

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
/*      // ProductsData productsData =
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
      // return productBrands;*/

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
        for (var element in element.productBrand!) {
          productBrands.add(element);
        }
      }

      return ProductBrandModel(productBrands: productBrands, error: "");
    } catch (err) {
      return ProductBrandModel.withError(err.toString());
    }
  }
}
