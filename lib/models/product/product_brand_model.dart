import 'package:lixshop/models/models.dart';
import 'package:lixshop/models/product/products_data_model.dart';

class ProductBrand {
  double? brandId;
  String? brandCode;
  String? brandName;
  String? brand;
  bool? newProd;
  bool? saleProd;
  bool? hotProd;

  ProductBrand({
    this.brandId,
    this.brandCode,
    this.brandName,
    this.brand,
    this.newProd,
    this.saleProd,
    this.hotProd,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
        brandId: json["brandid"] == null ? null : json["brandid"].toDouble(),
        brandCode: json["brandcode"],
        brandName: json["brandname"],
        brand: json["brand"],
        newProd: json["spmoi"],
        saleProd: json["spkm"],
        hotProd: json["spbanchay"],
      );

  Map<String, dynamic> toJson() => {
        "brandid": brandId,
        "brandcode": brandCode,
        "brandname": brandName,
        "brand": brand,
        "spmoi": newProd,
        "spkm": saleProd,
        "spbanchay": hotProd,
      };
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
    return ProductBrandModel(productBrands: productBrands, error: "");
  }

  factory ProductBrandModel.withError(String error) => ProductBrandModel(
        productBrands: [],
        error: error,
      );
}
