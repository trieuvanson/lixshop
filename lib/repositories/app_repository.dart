import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/models.dart';

class AppRepository {
  final dio = Dio();

  final String? mainUrl = dotenv.env['MAIN_API_URL'];

  Future<CityModel> getCity() async {
    try {
      final response = await dio.get('$mainUrl/datas/KxQcAQ9cWEJYLw==');
      print('response: ${jsonDecode(response.data)['cities']}');

      return CityModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      print(e);
      return CityModel.withError(e.toString());
    } catch (e) {
      print(e);
      return CityModel.withError(e.toString());
    }
  }

  DistrictsModel getDistrictsByCity(CityModel cityModel, int idCity) {
    try {
      DistrictsModel districtsModel = DistrictsModel();
      for (var item in cityModel.cities!) {
        if (item.id == idCity) {
          districtsModel.districts = item.districts;
        }
      }
      return DistrictsModel(error: "error");
    } on DioError catch (e) {
      print(e);
      return DistrictsModel(error: e.toString());
    } catch (e) {
      print(e);
      return DistrictsModel(error: e.toString());
    }
  }

  WardsModel getWardsByDistrict(DistrictsModel districtsModel, int idDistrict) {
    try {
      WardsModel wardsModel = WardsModel();
      for (var item in districtsModel.districts!) {
        if (item.id == idDistrict) {
          wardsModel.wards = item.wards;
        }
      }
      return WardsModel(error: "error");
    } on DioError catch (e) {
      print(e);
      return WardsModel(error: e.toString());
    } catch (e) {
      print(e);
      return WardsModel(error: e.toString());
    }
  }
}
