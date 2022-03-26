

import '../../models/models.dart';

abstract class BaseCategoryRepository {
  Future<ProductCateModel> getAllCategories();
}