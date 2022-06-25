import 'package:dio/dio.dart';
import '../../constants/env.dart';
import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';

class ResultDetailsDataRepository {
  final String detailsUrl = '$baseUrl/api/data/chitietsanpham/info';
  // final String detailsUrl = 'https://api.jsonbin.io/b/6253c7b4d8a4cc06909edfed';
  static final _dio = Dio();

  Future<ResultDetailsDataModel?> getResultDetailsData(int idBrand) async {
    try {
      var authorization = await secureStorage.readToken();
      String idDist = await secureStorage.readKey("idDist");
      final Response response = await _dio.get(detailsUrl,
          queryParameters: Params(idBrand: idBrand, idNPPs: idDist).toJson(),
          options: Options(headers: {
            "Authorization": "Bearer ${authorization!.accessToken}",
          }));
      print(response.data);
      if (response.data['err'] == -1) {
        throw Exception(response.data['msg']);
      }
      return ResultDetailsDataModel.fromJson(response.data['dt']);
    }  on DioError catch (e) {
      if (e.response?.statusCode == 401) {

      } else if (e.response?.statusCode == 404) {

      }
    } catch (e) {
      print('error: $e');
    }
    return null;
  }
}
final resultDetailsDataRepository = ResultDetailsDataRepository();


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

