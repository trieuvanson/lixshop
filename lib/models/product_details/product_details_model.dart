import '../models.dart';

class ProductDetail {
  int? idAgent;
  String? code;
  String? name;
  double? price;
  List<VoucherMethod>? voucherMethods;

  ProductDetail({
    this.idAgent,
    this.code,
    this.name,
    this.price,
    this.voucherMethods,
  });

  // FromJson
  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        idAgent: json["idagent"],
        code: json["code"],
        name: json["name"],
        price: json["price"],
        voucherMethods: List<VoucherMethod>.from(
            json["hinhThucKMDTOs"].map((x) => VoucherMethod.fromJson(x))),
      );
}
