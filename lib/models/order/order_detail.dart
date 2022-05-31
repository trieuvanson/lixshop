import 'package:lixshop/models/order/order_voucher_detail.dart';

class OrderDetail {
  String? productCode;
  String? productName;
  String? productUnit;
  double? quantityDetail;
  double? priceDetail;
  double? totalDetail;
  String? productImage;
  List<OrderVoucherDetail>? donHangDetailKmDTO2s;

  OrderDetail(
      {this.productCode,
      this.productName,
      this.productUnit,
      this.quantityDetail,
      this.priceDetail,
      this.totalDetail,
      this.productImage,
      this.donHangDetailKmDTO2s});

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productCode: json['productCode'],
        productName: json['productName'],
        productUnit: json['productUnit'],
        quantityDetail: json['quantityDetail'],
        priceDetail: json['priceDetail'],
        totalDetail: json['totalDetail'],
        productImage: json['productImage'],
        donHangDetailKmDTO2s: List<OrderVoucherDetail>.from(
            json["donHangDetailKmDTO2s"].map((x) => OrderVoucherDetail.fromJson(x))),
      );

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data:<String, dynamic>{};
//   data['productCode']:productCode;
//   data['productName']:productName;
//   data['productUnit']:productUnit;
//   data['quantityDetail']:quantityDetail;
//   data['priceDetail']:priceDetail;
//   data['totalDetail']:totalDetail;
//   if (donHangDetailKmDTO2s != null) {
//     data['donHangDetailKmDTO2s'] =
//         donHangDetailKmDTO2s!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}
