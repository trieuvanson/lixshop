import 'package:intl/intl.dart';

import 'order_detail.dart';

class Order {
  int? idDH;
  String? dateDH;
  String? tienhangDH;
  String? tongtienDH;
  String? status;
  String? agentLixName;
  List<OrderDetail>? donHangDetailDTO2s;

  Order(
      {this.idDH,
      this.dateDH,
      this.tienhangDH,
      this.tongtienDH,
      this.status,
      this.agentLixName,
      this.donHangDetailDTO2s});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        idDH: json['idDH'],
        dateDH: json['dateDH'],
        tienhangDH: json['tienhangDH'],
        tongtienDH: json['tongtienDH'],
        status: json['status'],
        agentLixName: json['agentLixName'],
        donHangDetailDTO2s: List<OrderDetail>.from(
            json["donHangDetailDTO2s"].map((x) => OrderDetail.fromJson(x))),
      );


  //tostring
  String toString() {
    return 'Order{idDH: $idDH, dateDH: $dateDH, tienhangDH: $tienhangDH, tongtienDH: $tongtienDH, status: $status, donHangDetailDTO2s: $donHangDetailDTO2s}';
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['idDH'] = idDH;
  //   data['dateDH'] = dateDH;
  //   data['tienhangDH'] = tienhangDH;
  //   data['tongtienDH'] = tongtienDH;
  //   data['status'] = status;
  //   if (donHangDetailDTO2s != null) {
  //     data['donHangDetailDTO2s'] =
  //         donHangDetailDTO2s!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
