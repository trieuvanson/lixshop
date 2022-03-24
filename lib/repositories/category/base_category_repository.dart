
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lixshop/models/models.dart';

abstract class BaseCategoryRepository {
  Future<ProductCateModel> getAllCategories();
}