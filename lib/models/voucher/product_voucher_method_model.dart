
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
      voucherMethodDetails: List<VoucherMethodDetails>.from(json["hinhThucKMDetailDTOs"]
          .map((x) => VoucherMethodDetails.fromJson(x)))
  );
}

class VoucherMethodModel {

  List<VoucherMethod>? voucherMethods;
  String? error;

  VoucherMethodModel({
    this.voucherMethods,
    this.error,
  });

  factory VoucherMethodModel.fromJson(Map<String, dynamic> json) {
    ProductDetailsModel productDetailsModel = ProductDetailsModel.fromJson(json);
    List<VoucherMethod> voucherMethods = [];
    for(var item in productDetailsModel.productDetails!) {
      voucherMethods.addAll(item.voucherMethods!);
    }
    return VoucherMethodModel(
      voucherMethods: voucherMethods,
      error: json["error"],
    );
  }





}


