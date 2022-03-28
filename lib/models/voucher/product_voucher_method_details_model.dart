class VoucherMethodDetails {
  int? productIdVoucher;
  String? code;
  String? name;
  String? productVoucherUnit;
  double? value;
  double? countValue;
  bool? wrap;
  bool? isRequired;

  VoucherMethodDetails({
    this.productIdVoucher,
    this.code,
    this.name,
    this.productVoucherUnit,
    this.value,
    this.countValue,
    this.wrap,
    this.isRequired,
  });

  // fromJson
  factory VoucherMethodDetails.fromJson(Map<String, dynamic> json) =>
      VoucherMethodDetails(
        productIdVoucher: json["productKmId"],
        code: json["code"],
        name: json["name"],
        productVoucherUnit: json["productKmUnit"],
        value: json["soluong"].toDouble(),
        countValue: json["soluongkm"].toDouble(),
        wrap: json["quankem"],
        isRequired: json["batbuoc"],
      );

  // toJson
  Map<String, dynamic> toJson() => {
        "productKmId": productIdVoucher,
        "code": code,
        "name": name,
        "productKmUnit": productVoucherUnit,
        "soluong": value,
        "soluongkm": countValue,
        "quankem": wrap,
        "batbuoc": isRequired,
      };
}

class VoucherMethodDetailsModel {
  List<VoucherMethodDetails>? voucherMethodDetails;
  String? error;

  VoucherMethodDetailsModel({
    this.voucherMethodDetails,
    this.error,
  });
}
