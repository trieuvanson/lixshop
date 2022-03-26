

import '../../models/models.dart';

abstract class BaseProductRepository {


  Future<ProductBrandModel> getAllProducts();
}