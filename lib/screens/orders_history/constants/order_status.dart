import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

final orderStatus = [
  "Tất cả",
  "Chờ xác nhận",
  "Đang giao hàng",
  "Hoàn tất",
  "Đã hủy"
];
final orderStatusMap = {
  "Tất cả": "ALL",
  "Chờ xác nhận": "Đang chờ.",
  "Đang giao hàng": "Đang giao hàng.",
  "Hoàn tất": "Đã hoàn tất.",
  "Đã hủy": "Đã hủy."
};

final orderStatusMapReverse = {
  "Đang chờ.": "Chờ xác nhận",
  "Đang giao hàng.": "Đang giao hàng",
  "Hoàn tất.": "Hoàn tất",
  "Đã hủy.": "Đã hủy"
};

final Map<String, Color> orderColorMap = {
  "Đang chờ.": Vx.green200,
  "b": Colors.grey[800]!,
  "c": Colors.grey[800]!,
  "d": Colors.grey[800]!,
};

final Map<String, Color> orderColorTextMap = {
  "Đang chờ.": Vx.green500,
  "b": Vx.white,
  "c": Vx.white,
  "d": Vx.white,
};

