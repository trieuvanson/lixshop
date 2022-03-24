import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lixshop/repositories/category/product_category_repositories.dart';
import 'package:lixshop/repositories/product/product_repositories.dart';

import '../repositories/products_data/products_data_repositories.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Future<void> decodeJson() async {
    const String mainURL = "http://192.168.0.226:65/shopee/datas/CL327";
    final Dio dio = Dio();

    final Response response = await dio.get(mainURL);
    print(jsonDecode(response.data)['cateSanPhams'][0]['brandSanPhams']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () {
          ProductCategoryRepository().getAllCategories().then((value) =>
              print('${value.productCates!.length}'));
        },
      ),
    );
  }
}
