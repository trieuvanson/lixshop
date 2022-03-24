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