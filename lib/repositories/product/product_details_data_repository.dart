import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lixshop/repositories/product/product_details_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';

class ProductDetailsDataRepository {
  final Dio _dio = Dio();
  final String mainURL =
      "http://192.168.0.203:8280/shopee/api/data/chitietsanpham/info?";

  Future<ProductDetailsDataModel> getProductDetails(
      int idBrand, List<String> idNPPs) async {
    try {
      var authorization =
          "Bearer eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MTU1ODU3LCJzdWIiOiJqYW5lIiwianRpIjoiMjllMDMwYjEtZTNmZi00M2I3LWI5MGUtNjA3ODJhYTA5YWI4IiwiaWF0IjoxNjQ4MDk5NjUzLCJleHAiOjE2NTYwNDg0NTN9.JL7FcJ5Bs6hvQlU8vYpG8sg6EhHDhGYitEgXr_R1ihnUsg1gH5TC0smpJP371neYCf-4Daqb6Mc3QFWXGnODQ8faBx3CXIhUII6Kp7EHyK5EmixQKNWDH_8wUcntpVjPJxCuFq_T8oOZT0u2okYhliFnglm-sOPDL7Ok5q7T6raAz-sf1ijbBoSW5SaKjQ5UTLD5u8Q5Pf85Xz6elXavHmCv-1dFXPpyZlpn6ED8OJ6_g_RPdqu1vDQvJgtsx2147vlXJFzRzdwUDTWcVdHCRWhK1rUDYJZ-Ac5dq7KpEuY4cmUKdq04n3DPMncaVWGaOYB10_VpgIwkO8bIEUKnhw";
      final Response response = await _dio.get(mainURL,
          queryParameters:
              Params(idBrand: idBrand, idNPPs: idNPPs.join(",")).toJson(),
          options: Options(headers: {
            "Authorization": authorization,
          }));
      if (response.data['err'] == -1) {
        return ProductDetailsDataModel.withError("${response.data['msg']}");
      }
      return ProductDetailsDataModel.fromJson(response.data);
    } on DioError catch (e) {
      return ProductDetailsDataModel.withError(
          "${e.response!.data['msg']}");
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
