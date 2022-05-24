import '../../models/models.dart';

class ProductDetailsDataController {
  List<ProductDetail> getProductDetails(
      ResultDetailsDataModel resultDetailsDataModel, String size) {
    List<ProductDetail> productDetails = [];
    try {
      List<ProductSizesList> productSizesList =
          resultDetailsDataModel.productSizesList!;
      for (var item in productSizesList) {
        if (item.size == size) {
          productDetails.addAll(item.productDetails!);
        }
      }
      return productDetails;
    } catch (e) {
      print(e);
    }
    return productDetails;
  }
}

