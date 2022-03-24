import '../models.dart';

class ProductCate {
  double? cateId;
  String? cateCode;
  String? cateName;
  String? catePath;
  List<ProductBrand>? productBrand;

  ProductCate({
    this.cateId,
    this.cateCode,
    this.cateName,
    this.catePath,
    this.productBrand,
  });

  factory ProductCate.fromJson(Map<String, dynamic> json) => ProductCate(
        cateId: json["catid"] == null ? null : json["catid"].toDouble(),
        cateCode: json["catcode"],
        cateName: json["catname"],
        catePath: json["catpath"],
        productBrand: json["brandSanPhams"] == null
            ? []
            : List<ProductBrand>.from(
                json["brandSanPhams"].map((x) => ProductBrand.fromJson(x))),
      );
}

class ProductCateModel {
  List<ProductCate>? productCates;
  String? error;

  ProductCateModel({
    this.productCates,
    this.error,
  });

  factory ProductCateModel.fromJson(Map<String, dynamic> json) {
    ProductsData productsData = ProductsData.fromJson(json);
    List<ProductCate> productCate =
        productsData.productCate!.map((e) => e).toList();
    return ProductCateModel(productCates: productCate, error: "");
  }

  factory ProductCateModel.withError(String error) =>
      ProductCateModel(productCates: [], error: error);
}
