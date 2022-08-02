import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

final orderStatus = [
  "Tất cả",
  "Chờ xác nhận",
  "Đã xác nhận",
  "Hoàn tất",
  "Đã hủy"
];
final orderStatusMap = {
  "Tất cả": "ALL",
  "Chờ xác nhận": "Đang chờ.",
  "Đã xác nhận": "Đã xác nhận",
  "Hoàn tất": "Đã hoàn tất.",
  "Đã hủy": "Đã hủy."
};

final orderStatusMapReverse = {
  "Đang chờ.": "Chờ xác nhận",
  "Đã xác nhận": "Đã xác nhận",
  "Hoàn tất.": "Hoàn tất",
  "Đã hủy.": "Đã hủy"
};

final Map<String, Color> orderColorMap = {
  "Đang chờ.": Vx.green200,
  "Đã xác nhận": Colors.grey[800]!,
  "Hoàn tất.": Colors.grey[800]!,
  "Đã hủy.": Colors.grey[800]!,
};

final Map<String, Color> orderColorTextMap = {
  "Đang chờ.": Vx.green500,
  "Đã xác nhận": Vx.white,
  "Hoàn tất.": Vx.white,
  "Đã hủy.": Vx.white,
};

