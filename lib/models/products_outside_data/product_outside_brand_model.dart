
class ProductOutsideBrand {
  double? brandId;
  String? brandCode;
  String? brandName;
  String? brand;
  bool? isNew;
  bool? isSale;
  bool? isHot;

  ProductOutsideBrand({
    this.brandId,
    this.brandCode,
    this.brandName,
    this.brand,
    this.isNew,
    this.isSale,
    this.isHot,
  });



  factory ProductOutsideBrand.fromJson(Map<String, dynamic> json) =>
      ProductOutsideBrand(
        brandId: json["brandid"].toDouble(),
        brandCode: json["brandcode"],
        brandName: json["brandname"],
        brand: json["brand"],
        isNew: json["spmoi"],
        isSale: json["spkm"],
        isHot: json["spbanchay"],
      );

  Map<String, dynamic> toJson() => {
        "brandid": brandId,
        "brandcode": brandCode,
        "brandname": brandName,
        "brand": brand,
        "spmoi": isNew,
        "spkm": isSale,
        "spbanchay": isHot,
      };
}
