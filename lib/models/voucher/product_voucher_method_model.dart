
import '../models.dart';

class VoucherMethod {
  int? typeform;
  List<VoucherMethodDetails>? voucherMethodDetails;

  VoucherMethod({
    this.typeform,
    this.voucherMethodDetails,
  });

  // from Json

  factory VoucherMethod.fromJson(Map<String, dynamic> json) => VoucherMethod(
        typeform: json["typeprom"],
        voucherMethodDetails: json["hinhThucKMDetailDTOs"] == null
            ? null
            : List<VoucherMethodDetails>.from(json["hinhThucKMDetailDTOs"]
                .map((x) => VoucherMethodDetails.fromJson(x))),
      );
}

