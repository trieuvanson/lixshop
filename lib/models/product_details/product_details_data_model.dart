import '../models.dart';

class ProductDetailsData {
  int? idBrand;
  List<String>? sizes;
  List<ProductSizes>? productSizesList;

  ProductDetailsData({
    this.idBrand,
    this.sizes,
    this.productSizesList,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      ProductDetailsData(
        idBrand: json["idBrand"],
        sizes: List<String>.from(json["sizes"].map((x) => x)),
        productSizesList: List<ProductSizes>.from(
            json["sizeSanPhamDTOs"].map((x) => ProductSizes.fromJson(x))),
      );
}

class ProductDetailsDataModel {
  ProductDetailsData? productDetailsData;
  String? error;

  ProductDetailsDataModel({
    this.productDetailsData,
    this.error,
  });

  factory ProductDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsDataModel(
          productDetailsData: ProductDetailsData.fromJson(json['dt']),
          error: "");

  factory ProductDetailsDataModel.withError(String error) =>
      ProductDetailsDataModel(productDetailsData: null, error: error);
}
