import '../models.dart';

class ProductSizes {
  String? size;
  List<ProductDetail>? productDetails;

  ProductSizes({
    this.size,
    this.productDetails,
  });
  factory ProductSizes.fromJson(Map<String, dynamic> json) => ProductSizes(
    size: json["size"],
    productDetails: List<ProductDetail>.from(json["sanPhamDTOs"].map((x) => ProductDetail.fromJson(x))),
  );

}

class ProductSizesModel {
  List<ProductSizes>? productSizes;
  String? error;

  ProductSizesModel({
    this.productSizes,
    this.error,
  });

  // FromJson
  factory ProductSizesModel.fromJson(Map<String, dynamic> json) {
    ProductDetailsDataModel productDetailsDataModel =
    ProductDetailsDataModel.fromJson(json);
    return ProductSizesModel(
      productSizes: productDetailsDataModel.productDetailsData?.productSizesList,
      error: "",
    );
  }

  factory ProductSizesModel.withError(dynamic error) => ProductSizesModel(
      productSizes: [],
      error: error
  );
}