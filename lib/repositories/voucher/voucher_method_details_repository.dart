// import 'package:lixshop/models/models.dart';
//
// import '../repositories.dart';
//
// class VoucherMethodDetailsRepository {
//
//
//
//   VoucherMethodDetailsModel getVoucherMethodDetails(ProductDetailsDataModel productDetailsDataModel) {
//     try {
//       List<VoucherMethodDetails> voucherMethodDetails = [];
//       VoucherMethodModel voucherMethodModel =
//       VoucherMethodRepository().getVoucherMethodsByProduct(productDetailsDataModel);
//       for (var element in voucherMethodModel.voucherMethods!) {
//         voucherMethodDetails.addAll(element.voucherMethodDetails!);
//       }
//
//       return VoucherMethodDetailsModel(
//         error: "",
//         voucherMethodDetails: voucherMethodDetails,
//       );
//     } catch (e) {
//       print(e);
//       return VoucherMethodDetailsModel(
//         error: e.toString(),
//         voucherMethodDetails: [],
//       );
//     }
//   }
//
//
//
//
// }