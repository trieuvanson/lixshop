import 'package:lixshop/repositories/product/product_sizes_repository.dart';

import '../../models/models.dart';

class ProductDetailsRepository {
//   final Dio _dio = Dio();
//   final String mainURL = "http://192.168.0.203:8280/shopee/api/data/chitietsanpham/info";
//
//
//   Future<ProductDetailsDataModel> getProductDetails(
//       int idBrand, List<int> idNPPs) async {
//     Params params = Params(idBrand: idBrand, idNPPs: [5,3]);
//     String authorization =
//         "eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MTU1ODU3LCJzdWIiOiJqYW5lIiwianRpIjoiNTk4YWQ3MTEtMGQ4ZS00M2I1LWE3NzMtNzBlM2U0NTJjOGFkIiwiaWF0IjoxNjQ4MDkzODkzLCJleHAiOjE2NTYwNDI2OTN9.FMmfwZBvXHlYMANe_fwlv4eaLz0hWUA4NdmvKSCNAHO_Upzg2h57Dg_j28p8HC5DPYYfl8_XHBxzhAR7_7rZS03psxN7PQYyLWydEP3W75SxqumjTCLCOwZAWiE7fNL7t5Y0LXxaIkL63L08BmkxVOz54iCNCdpB69hZQmG6DZXkqTrPo8Zf02upfaSNbRt7i_e1qgVbQum1fl0wcw4NBVrZqbLaV0XQTUDTlucS5-r7HF4hIOAcNt7jkTcwnkUm9hR7Xo3RAf3CFWXJgFm5gCbpD7QxRH8ZrYaOEAIQpUKw40MMogm41mBsUIPbuHyvs9RMac4qfg4FuQTkTwNbZA";
//     try {
//       var authorization = "Bearer eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MTU1ODU3LCJzdWIiOiJqYW5lIiwianRpIjoiMjllMDMwYjEtZTNmZi00M2I3LWI5MGUtNjA3ODJhYTA5YWI4IiwiaWF0IjoxNjQ4MDk5NjUzLCJleHAiOjE2NTYwNDg0NTN9.JL7FcJ5Bs6hvQlU8vYpG8sg6EhHDhGYitEgXr_R1ihnUsg1gH5TC0smpJP371neYCf-4Daqb6Mc3QFWXGnODQ8faBx3CXIhUII6Kp7EHyK5EmixQKNWDH_8wUcntpVjPJxCuFq_T8oOZT0u2okYhliFnglm-sOPDL7Ok5q7T6raAz-sf1ijbBoSW5SaKjQ5UTLD5u8Q5Pf85Xz6elXavHmCv-1dFXPpyZlpn6ED8OJ6_g_RPdqu1vDQvJgtsx2147vlXJFzRzdwUDTWcVdHCRWhK1rUDYJZ-Ac5dq7KpEuY4cmUKdq04n3DPMncaVWGaOYB10_VpgIwkO8bIEUKnhw";
//       final Response response = await _dio.get(mainURL, queryParameters: const Params(idBrand: 453, idNPPs: [5, 3]).toJson(), options: Options(headers: {
//         "Authorization": authorization,
//       }));
//       print('Response status: ${response.data['dt']}');
//       return ProductDetailsDataModel.fromJson(response.data);
//     } catch (e) {
//       print('Error: $e');
//       return ProductDetailsDataModel.withError(e.toString());
//     }
//   }
// }
//
// class Params {
//   final int idBrand;
//   final List<int> idNPPs;
//
//   const Params({
//     required this.idBrand,
//     required this.idNPPs,
//   });
//
//   Map<String, dynamic> toJson() => {
//         'idBrand': idBrand,
//         'idNPPs': idNPPs,
//       };

  ProductDetailsModel getProductDetails(
      ProductDetailsDataModel productDetailsDataModel) {
    try {
      List<ProductDetail> productDetails = [];
      ProductSizesModel productSizesModel =
          ProductSizesRepository().getProductSizes(productDetailsDataModel);
      for (var element in productSizesModel.productSizes!) {
        productDetails.addAll(element.productDetails!);
      }
      print(productDetails.length);
      return ProductDetailsModel(
        error: "",
        productDetails: productDetails,
      );
    } catch (e) {
      print(e);
      return ProductDetailsModel(
        error: e.toString(),
        productDetails: [],
      );
    }
  }
}
