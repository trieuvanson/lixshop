
import 'package:lixshop/models/models.dart';
import 'package:lixshop/models/product/products_data.dart';

class ProductBrand {
  double? brandId;
  String? brandCode;
  String? brandName;
  String? brand;
  bool? newProd;
  bool? promotionProd;
  bool? hotProd;

  ProductBrand({
    this.brandId,
    this.brandCode,
    this.brandName,
    this.brand,
    this.newProd,
    this.promotionProd,
    this.hotProd,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
        brandId: json["brandid"] == null ? null : json["brandid"].toDouble(),
        brandCode: json["brandcode"],
        brandName: json["brandName"],
        brand: json["brand"],
        newProd: json["spmoi"],
        promotionProd:
            json["spkm"],
        hotProd: json["spbanchay"],
      );
}


class ProductBrandModel {
  List<ProductBrand>? productBrands;
  String? error;

  ProductBrandModel({
    this.productBrands,
    this.error,
  });

  factory ProductBrandModel.fromJson(Map<String, dynamic> json) {
    ProductsData productsData = ProductsData.fromJson(json);
    List<ProductCate> productCate =
    productsData.productCate!.map((e) => e).toList();
    List<ProductBrand> productBrands = [];
    for (var element in productCate) {
      for (var element in element.productBrand!) {
        productBrands.add(element);
      }
    }
    return ProductBrandModel(
      productBrands: productBrands,
      error: ""
    );
  }


  factory ProductBrandModel.withError(String error) => ProductBrandModel(
    productBrands: [],
    error: error,
  );
}
