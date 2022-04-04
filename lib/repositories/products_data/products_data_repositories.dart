import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/repositories/auth/user_repository.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';

import '../../models/models.dart';
import 'base_products_data_repository.dart';

class ProductsDataRepositories extends BaseProductsDataRepository {
  static final Dio _dio = Dio();
  static const String? mainProdUrl = "http://192.168.0.226:65/shopee/datas/";

  // static List nppUrl = ["DCtbW1k=", "CylYXlo="];

  @override
  Future<ProductsDataModel> getProductsData() async {
    try {
      List<String> nppLinkList = await secureStorage.checkLogin()
          ? await userRepository.loadLocation()
          : ["DCtbW1k="];
      var responses = await Future.wait([
        for (var link in nppLinkList)
          _dio.get(
            "$mainProdUrl$link",
          ),
      ]);
      ProductsDataModel productsDataModel =
          _getProductCateFromResponse(responses);
      await secureStorage.addKey("idDistris", productsDataModel.data!.idNpp);
      return productsDataModel;
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (err) {
      print('Error: $err');
      return ProductsDataModel.withError("Có lỗi xảy ra");
    }
  }

  ProductsDataModel _getProductCateFromResponse(List<dynamic> responses) {
    List<ProductCate> productCatesMain = [];
    List<String> idNpps = [];

    for (var response in responses) {
      ProductsDataModel productsDataModel =
          ProductsDataModel.fromJson(json.decode(response.data));
      idNpps.add(productsDataModel.data!.idNpp!);
      for (var cate in productsDataModel.data!.productCate!) {
        bool statusMain = true;
        for (var cateMain in productCatesMain) {
          if (cate.cateId == cateMain.cateId) {
            statusMain = false;
            for (var brand in cate.productBrand!) {
              bool statusSub = true;
              for (var brandMain in cateMain.productBrand!) {
                if (brandMain.brandId == brand.brandId) {
                  statusSub = false;
                  break;
                }
              }
              if (statusSub) {
                cateMain.productBrand!.add(brand);
              }
            }
          }
        }
        if (statusMain) {
          productCatesMain.add(cate);
        }
      }
    }
    ProductsDataModel productsDataModel = ProductsDataModel(
      data: ProductsData(
        idNpp: idNpps.join(","),
        productCate: productCatesMain,
      ),
    );
    return productsDataModel;
  }
}
