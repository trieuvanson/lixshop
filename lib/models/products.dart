// import 'dart:convert';
//
// import 'package:flutter/services.dart';
// import 'package:lixshop/models/product.dart';
//
// List<Product> products = [];
//
// class Products {
//   Future<void> decodeJson() async {
//     String products = await rootBundle.loadString('assets/json/products.json');
//     final productMap = await json.decode(products);
//     return productMap;
//   }
//   List<Product> products = decodeJson();
// }