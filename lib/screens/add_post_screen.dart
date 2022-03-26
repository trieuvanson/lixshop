import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lixshop/models/models.dart';
import 'package:path_provider/path_provider.dart';

import '../repositories/product/product_details_data_repository.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Future<void> decodeJson() async {
    // // const String mainURL = "http://192.168.0.226:65/shopee/datas/CL327";
    // const String mainURL = "http://192.168.0.203:8280/shopee/api/data/chitietsanpham/info";
    // // const String mainURL = "http://192.168.0.203:8280/shopee/api/data/chitietsanpham/info";
    // final Dio dio = Dio();
    // var authorization = "Bearer eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MTU1ODU3LCJzdWIiOiJqYW5lIiwianRpIjoiMjllMDMwYjEtZTNmZi00M2I3LWI5MGUtNjA3ODJhYTA5YWI4IiwiaWF0IjoxNjQ4MDk5NjUzLCJleHAiOjE2NTYwNDg0NTN9.JL7FcJ5Bs6hvQlU8vYpG8sg6EhHDhGYitEgXr_R1ihnUsg1gH5TC0smpJP371neYCf-4Daqb6Mc3QFWXGnODQ8faBx3CXIhUII6Kp7EHyK5EmixQKNWDH_8wUcntpVjPJxCuFq_T8oOZT0u2okYhliFnglm-sOPDL7Ok5q7T6raAz-sf1ijbBoSW5SaKjQ5UTLD5u8Q5Pf85Xz6elXavHmCv-1dFXPpyZlpn6ED8OJ6_g_RPdqu1vDQvJgtsx2147vlXJFzRzdwUDTWcVdHCRWhK1rUDYJZ-Ac5dq7KpEuY4cmUKdq04n3DPMncaVWGaOYB10_VpgIwkO8bIEUKnhw";
    // final Response response = await dio.get(mainURL, queryParameters: const Params(idBrand: 453, idNPPs: "5,3").toJson(), options: Options(headers: {
    //   "Authorization": authorization,
    // }));
    // print(response.data);
    var testJson = {
      "id": 1,
      "name": "test",
      "price": "1",
      "image": "test",
      "description": "test",
      "idBrand": 1,
    };
    // final directory = await getApplicationDocumentsDirectory();
    // final file = File('${directory.path}/cart.json');
    // final file1 = File('${directory.path}/test');
    // //encode json be
    // // await file1.writeAsBytes(utf8.encode(jsonEncode(testJson)));
    // // print(utf8.encode(jsonEncode(testJson)));
    // // print(file1.path);
    // final contents = await file1.readAsBytes();
    // print('Contents: $contents');
    // //
    // var json = await file.readAsString();
    // List<Cart> carts = (jsonDecode(json)['cart'] as List).map((e) => Cart.fromJson(e)).toList();
    // CartModel cartModel = CartModel.fromJson(jsonDecode(json));
    // print('cartModel: $cartModel');
    // print('carts: ${carts[0].quantity}');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () {
          decodeJson();
        },
      ),
    );
  }
}
