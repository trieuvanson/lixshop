import '../models.dart';
class VoucherMethod {
  int? typeform;
  int? typeformCus;
  List<VoucherMethodDetails>? voucherMethodDetails;

  VoucherMethod({
    this.typeform,
    this.voucherMethodDetails,
    this.typeformCus,
  });

  // from Json

  factory VoucherMethod.fromJson(Map<String, dynamic> json) => VoucherMethod(
      typeform: json["typeprom"],
      typeformCus: json["typepromCus"],
      voucherMethodDetails: List<VoucherMethodDetails>.from(json["hinhThucKMDetailDTOs"]
          .map((x) => VoucherMethodDetails.fromJson(x)))
  );

  // to Json

  Map<String, dynamic> toJson() => {
    "typeprom": typeform,
    "hinhThucKMDetailDTOs": List<dynamic>.from(voucherMethodDetails!.map((x) => x.toJson())),
    "typepromCus": typeformCus,
  };
}
