import 'package:lixshop/models/voucher/voucher_details_dto.dart';

import '../../models/models.dart';

class VoucherController {
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

  List<VoucherMethodDetails> getVoucherMethodDetailsByMethod(
      VoucherMethod method) {
    List<VoucherMethodDetails> voucherMethodDetails = [];
    try {
      voucherMethodDetails.addAll(method.voucherMethodDetails!);
      return voucherMethodDetails;
    } catch (e) {
      print(e);
    }
    return voucherMethodDetails;
  }

  List<VoucherDetailsDTO> filterVoucherDetailsByCart(
      Cart cart, VoucherMethod method) {
    List<VoucherDetailsDTO> voucherDetails = [];
    try {
      for (var detail in method.voucherMethodDetails!) {
        int? value = cart.unit != "THÙNG"
            ? cart.quantity! ~/ cart.productDetail!.changeValue!
            : cart.quantity;
        int quantity = value! ~/ detail.value!;
        if (quantity > 0) {
          voucherDetails.add(VoucherDetailsDTO(
            voucherDetailName: detail.name!,
            quantity: (quantity * detail.countValue!).toInt().toString() +
                " ${detail.productVoucherUnit!}",
          ));
        }
      }
      return voucherDetails;
    } catch (e) {
      print(e);
    }
    return voucherDetails;
  }
}

final voucherController = VoucherController();
