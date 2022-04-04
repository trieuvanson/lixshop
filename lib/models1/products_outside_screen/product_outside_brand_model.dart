class ProductOutsideBrand {
  double? brandId;
  String? brandCode;
  String? brandName;
  String? brand;
  bool? newProd;
  bool? saleProd;
  bool? hotProd;

  ProductOutsideBrand({
    this.brandId,
    this.brandCode,
    this.brandName,
    this.brand,
    this.newProd,
    this.saleProd,
    this.hotProd,
  });

  factory ProductOutsideBrand.fromJson(Map<String, dynamic> json) =>
      ProductOutsideBrand(
        brandId: json["brandid"].toDouble(),
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
