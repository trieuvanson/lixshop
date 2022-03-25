import 'package:lixshop/repositories/product/product_sizes_repository.dart';

import '../../models/models.dart';

class ProductDetailsRepository {
  ProductDetailsModel getProductDetails(
      ProductDetailsDataModel productDetailsDataModel, int index) {
    try {
      List<ProductDetail> productDetails = [];
      ProductSizesModel productSizesModel =
      ProductSizesRepository().getProductSizes(productDetailsDataModel);
      print(productSizesModel.productSizes![index].size);
      productDetails.addAll(productSizesModel.productSizes![index].productDetails!);
      print('So luong: ${productDetails.length}');
      return ProductDetailsModel(
        error: "",
        productDetails: productDetails,
      );
    } catch (e) {
      print(e);
      return ProductDetailsModel(
        error: e.toString(),
        productDetails: [],
      );
    }
  }
}
