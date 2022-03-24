
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lixshop/models/models.dart';

abstract class BaseProductRepository {


  Future<ProductBrandModel> getAllProducts();
}