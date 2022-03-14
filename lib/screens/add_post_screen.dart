import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/product.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Future<void> decodeJson() async {
    String productss = await rootBundle.loadString('assets/json/products.json');
    final productMap = await json.decode(productss);
    var products = productMap.map((product) => Product.fromMap(product)).toList();
    print(products[1].id);
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
