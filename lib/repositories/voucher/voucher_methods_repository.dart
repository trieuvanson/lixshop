import 'package:lixshop/models/models.dart';

import '../repositories.dart';

class VoucherMethodRepository {
  // Future<VoucherMethod> getVoucherByProduct(ProductDetail productDetail) {
  //
  // }

  VoucherMethodModel getVoucherMethodsByProduct(
      ProductDetail productDetail) {
    try {
      List<VoucherMethod> voucherMethods = [];
      for (var element in productDetail.voucherMethods!) {
        voucherMethods.add(element);
      }

      return VoucherMethodModel(
        error: "",
        voucherMethods: voucherMethods,
      );
    } catch (e) {
      print(e);
      return VoucherMethodModel(
        error: e.toString(),
        voucherMethods: [],
      );
    }
  }
}
