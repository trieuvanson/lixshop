
import '../../models/models.dart';

class VoucherMethodDetailsController {
  List<VoucherMethodDetails> getVoucherMethodDetailsByMethod(VoucherMethod method) {
    List<VoucherMethodDetails> voucherMethodDetails = [];
    try {
      voucherMethodDetails.addAll(method.voucherMethodDetails!);
      return voucherMethodDetails;
    } catch (e) {
      print(e);
    }
    return voucherMethodDetails;
  }
}

final voucherMethodDetailsController = VoucherMethodDetailsController();
