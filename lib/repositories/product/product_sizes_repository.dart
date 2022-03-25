import 'package:lixshop/models/models.dart';

class ProductSizesRepository {
  ProductSizesModel getProductSizes(
      ProductDetailsDataModel productDetailsDataModel) {
    try {
      return ProductSizesModel(
        error: "",
        productSizes: productDetailsDataModel.productDetailsData!.productSizesList,
      );
    } catch (e) {
      return ProductSizesModel(
        error: e.toString(),
        productSizes: [],
      );
    }
  }
}
