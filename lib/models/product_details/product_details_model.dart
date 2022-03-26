import '../models.dart';

class ProductDetail {
  int? idAgent;
  String? code;
  String? name;
  int? price;
  String? pathImg;
  List<VoucherMethod>? voucherMethods;

  ProductDetail({
    this.idAgent,
    this.code,
    this.name,
    this.pathImg,
    this.price,
    this.voucherMethods,
  });

  // FromJson
  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
      idAgent: json["idagent"],
      code: json["code"],
      name: json["name"],
      pathImg: json["pathImg"],
      price: json["gia"],
      voucherMethods: List<VoucherMethod>.from(
          json["hinhThucKMDTOs"].map((x) => VoucherMethod.fromJson(x)))
  );

  // ToJson
  Map<String, dynamic> toJson() => {
    "idagent": idAgent,
    "code": code,
    "name": name,
    "pathImg": pathImg,
    "gia": price,
    "hinhThucKMDTOs": List<dynamic>.from(voucherMethods!.map((x) => x.toJson())),
  };
}

class ProductDetailsModel {
  List<ProductDetail>? productDetails;
  String? error;

  ProductDetailsModel({
    this.productDetails,
    this.error,
  });

  // FromJson
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    ProductSizesModel productSizesModel = ProductSizesModel.fromJson(json);
    List<ProductDetail> productDetails = [];

    for (var item in productSizesModel.productSizes!) {
      productDetails.addAll(item.productDetails!);
    }

    return ProductDetailsModel(
      productDetails: productDetails,
      error: "",
    );
  }

  factory ProductDetailsModel.withError(dynamic error) {
    return ProductDetailsModel(
      productDetails: null,
      error: error,
    );
  }
}
