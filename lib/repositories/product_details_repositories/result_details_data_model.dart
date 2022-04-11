import 'package:dio/dio.dart';
import '../../constants/env.dart';
import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';

class ResultDetailsDataRepository {
  final String detailsUrl = '$baseUrl/api/data/chitietsanpham/info';
  static final _dio = Dio();

  Future<ResultDetailsDataModel> getResultDetailsData(int idBrand) async {
    try {
      var authorization = await secureStorage.readToken();
      print(await secureStorage.readKey("idDist"));
      String idDist = await secureStorage.readKey("idDist");
      print(idDist);
      final Response response = await _dio.get(detailsUrl,
          queryParameters: Params(idBrand: idBrand, idNPPs: idDist).toJson(),
          options: Options(headers: {
            "Authorization": "Bearer ${authorization!.accessToken}",
          }));
      print(response.realUri);
      print(response.data);
      if (response.data['err'] == -1) {
        throw Exception(response.data['msg']);
      }
      return ResultDetailsDataModel.fromJson(response.data['dt']);
    }  on DioError catch (e) {
      if (e.response?.statusCode == 401) {

      } else if (e.response?.statusCode == 404) {

      }
      throw Exception(e.response?.data['msg']);
    } catch (e) {
      print('error: $e');
      return {} as ResultDetailsDataModel;
    }
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

