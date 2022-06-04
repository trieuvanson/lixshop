// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartHiveAdapter extends TypeAdapter<CartHive> {
  @override
  final int typeId = 1;

  @override
  CartHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartHive(
      productDetail: fields[0] as ProductDetail?,
      quantity: fields[1] as int?,
      unit: fields[2] as String?,
      voucherMethod: fields[3] as VoucherMethod?,
      brandId: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CartHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productDetail)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.voucherMethod)
      ..writeByte(4)
      ..write(obj.brandId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
