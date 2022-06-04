import 'package:hive/hive.dart';

import '../models.dart';

part 'cart_hive.g.dart';

@HiveType(typeId: 1)
class CartHive {
  @HiveField(0)
  ProductDetail? productDetail;

  @HiveField(1)
  int? quantity;

  @HiveField(2)
  String? unit;

  @HiveField(3)
  VoucherMethod? voucherMethod;

  @HiveField(4)
  int? brandId;

  @HiveField(5)
  int? typeformVoucher;

  CartHive({
    this.productDetail,
    this.quantity,
    this.unit,
    this.voucherMethod,
    this.brandId,
    this.typeformVoucher,
  });
}
