

import '../../models/models.dart';

abstract class BaseProductsDataRepository {

  Future<ProductsDataModel> getProductsData();
}