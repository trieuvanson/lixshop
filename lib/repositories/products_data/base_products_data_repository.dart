
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/models/product/products_data.dart';

abstract class BaseProductsDataRepository {

  Future<ProductsData> getProductsData();
}