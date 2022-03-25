
class VoucherMethodDetails {
  String? code;
  String? name;
  double? value;
  double? countValue;
  bool? wrap;
  bool? isRequired;

  VoucherMethodDetails({
    this.code,
    this.name,
    this.value,
    this.countValue,
    this.wrap,
    this.isRequired,
  });

  // fromJson
  factory VoucherMethodDetails.fromJson(Map<String, dynamic> json) =>
      VoucherMethodDetails(
        code: json["code"],
        name: json["name"],
        value: json["soluong"].toDouble(),
        countValue: json["soluongkm"].toDouble(),
        wrap: json["quankem"],
        isRequired: json["batbuoc"],
      );
}

class VoucherMethodDetailsModel {
  List<VoucherMethodDetails>? voucherMethodDetails;
  String? error;


  VoucherMethodDetailsModel({
    this.voucherMethodDetails,
    this.error,
  });
}
