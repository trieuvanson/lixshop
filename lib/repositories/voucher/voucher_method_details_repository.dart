import 'package:lixshop/models/models.dart';

import '../repositories.dart';

class VoucherMethodDetailsRepository {



  VoucherMethodDetailsModel getVoucherMethodDetailsByMethod(VoucherMethod method) {
    try {
      List<VoucherMethodDetails> voucherMethodDetails = [];
      voucherMethodDetails.addAll(method.voucherMethodDetails!);

      return VoucherMethodDetailsModel(
        error: "",
        voucherMethodDetails: voucherMethodDetails,
      );
    } catch (e) {
      print(e);
      return VoucherMethodDetailsModel(
        error: e.toString(),
        voucherMethodDetails: [],
      );
    }
  }




}