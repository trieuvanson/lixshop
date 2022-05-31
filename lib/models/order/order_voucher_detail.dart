class OrderVoucherDetail {
  String? masanphamDetailKm;
  String? nameProductDetailKm;
  double? quantityDetailKm;
  String? unitDetailKm;

  OrderVoucherDetail(
      {this.masanphamDetailKm,
        this.nameProductDetailKm,
        this.quantityDetailKm,
        this.unitDetailKm});

  factory OrderVoucherDetail.fromJson(Map<String, dynamic> json) => OrderVoucherDetail(
    masanphamDetailKm:json['masanphamDetailKm'],
    nameProductDetailKm:json['nameProductDetailKm'],
        quantityDetailKm:json['quantityDetailKm'],
    unitDetailKm:json['unitDetailKm'],
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data:<String, dynamic>{};
  //   data['masanphamDetailKm']:masanphamDetailKm;
  //   data['nameProductDetailKm']:nameProductDetailKm;
  //   data['quantityDetailKm']:quantityDetailKm;
  //   data['unitDetailKm']:unitDetailKm;
  //   return data;
  // }
}