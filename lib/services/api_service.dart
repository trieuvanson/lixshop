import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lixshop/models1/models.dart';

import '../repositories/auth/user_repository.dart';
import '../utils/helpers/secure_storage.dart';

class APIService<T> {
  String? url;
  dynamic body;
  List<File>? files;
  T Function(Response response)? parse;

  APIService({this.url, this.body, this.parse, this.files});


}

class APIRequest {
  final _dio = Dio();

  get<T>(APIService<T> resource) async {
    final response = await _dio.get(resource.url!);
    if (resource.parse != null) {
      return resource.parse!(response);
    } else {
      throw Exception(response.statusCode);
    }
  }
}

final apiRequest = APIRequest();

class ProductRepository {
  static Future<List<APIService<ResultDataModel>>> getAll() async {
    List<String> nppLinkList = await secureStorage.checkLogin()
        ? await userRepository.loadLocation()
        : ["DCtbW1k="];
    List<APIService<ResultDataModel>> list = [];
    for (var link in nppLinkList) {
      list.add(APIService(
        url: 'http://192.168.0.226:65/shopee/datas/$link',
        parse: (response) {
          return ResultDataModel.fromJson(json.decode(response.data));
        },
      ));
    }
    return list;
  }
}

main() async {
  print('start');
}