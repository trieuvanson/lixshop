import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lixshop/repositories/product/product_details_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';

class ProductDetailsDataRepository {
  final Dio _dio = Dio();
  final String mainURL =
      "http://192.168.0.226:65/shopee/api/data/chitietsanpham/info";

  Future<ProductDetailsDataModel> getProductDetails(
      int idBrand, String idNPPs) async {
    try {
      var authorization = await secureStorage.readToken();
      final Response response = await _dio.get(mainURL,
          queryParameters: Params(idBrand: idBrand, idNPPs: idNPPs).toJson(),
          options: Options(headers: {
            "Authorization": "Bearer ${authorization!.accessToken}",
          }));
      if (response.data['err'] == -1) {
        return ProductDetailsDataModel.withError("${response.data['msg']}");
      }
      return ProductDetailsDataModel.fromJson(response.data);
    }  on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return ProductDetailsDataModel.withError("${e.response!.data}");
      } else if (e.response?.statusCode == 404) {
        return ProductDetailsDataModel.withError(e.response!.data);
      }
      return ProductDetailsDataModel.withError("Lỗi kết nối");
    }
  }
}

class Params {
  final int idBrand;
  final String idNPPs;

  const Params({
    required this.idBrand,
    required this.idNPPs,
  });

  Map<String, dynamic> toJson() => {
        'idBrand': idBrand,
        'idNPPs': idNPPs,
      };
}
