import '../models.dart';

class ProductOutsideCategory {
  double? cateId;
  String? cateCode;
  String? cateName;
  String? catePath;
  List<ProductOutsideBrand>? productBrand;

  ProductOutsideCategory({
    this.cateId,
    this.cateCode,
    this.cateName,
    this.catePath,
    this.productBrand,
  });

  factory ProductOutsideCategory.fromJson(Map<String, dynamic> json) =>
      ProductOutsideCategory(
        cateId: json["catid"].toDouble(),
        cateCode: json["catcode"],
        cateName: json["catname"],
        catePath: json["catpath"],
        productBrand: json["brandSanPhams"] == null
            ? []
            : List<ProductOutsideBrand>.from(json["brandSanPhams"]
                .map((x) => ProductOutsideBrand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "catid": cateId,
        "catcode": cateCode,
        "catname": cateName,
        "catpath": catePath,
        "brandSanPhams": productBrand == null
            ? null
            : List<dynamic>.from(productBrand!.map((x) => x.toJson())),
      };
}
