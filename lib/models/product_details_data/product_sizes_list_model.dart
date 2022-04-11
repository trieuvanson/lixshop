
import '../models.dart';

class ProductSizesList {
  String? size;
  List<ProductDetail>? productDetails;

  ProductSizesList({
    this.size,
    this.productDetails,
  });
  factory ProductSizesList.fromJson(Map<String, dynamic> json) => ProductSizesList(
    size: json["size"],
    productDetails: List<ProductDetail>.from(json["sanPhamDTOs"].map((x) => ProductDetail.fromJson(x))),
  );
}