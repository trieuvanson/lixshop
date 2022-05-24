
import '../../models/models.dart';

class VoucherMethodController {
  List<VoucherMethod> getVoucherMethodsByProduct(ProductDetail productDetail) {
    List<VoucherMethod> voucherMethods = [];
    try {
      for (var element in productDetail.voucherMethods!) {
        voucherMethods.add(element);
      }
      return voucherMethods;
    } catch (e) {
      print(e);
    }
    return voucherMethods;
  }
}

