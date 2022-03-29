import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lixshop/contains/contains.dart';
import 'package:lixshop/models/models.dart';

class Cart {
  ProductDetail? productDetail;
  int? quantity;
  String? unit;
  int? typeformVoucher;

  Cart({this.productDetail, this.quantity, this.unit, this.typeformVoucher});

  @override
  String toString() {
    return 'Cart{productDetail: ${productDetail ?? ""}, quantity: $quantity, unit: $unit, typeformVoucher: $typeformVoucher}';
  }

  int? getVoucherMethodFromProductDetail(
      ProductDetail productDetail, int selectVoucher) {
    return productDetail.voucherMethods
        ?.firstWhere((element) => element.typeformCus == selectVoucher,
            orElse: () => VoucherMethod(typeform: -1))
        .typeform;
  }

  String? getPricesChangeValue() {
    String value = "";
    if (unit == "THÙNG") {
      value = convertCurrencyToVND(
              productDetail!.price! * productDetail!.changeValue!) +
          "đ/THÙNG";
    } else {
      value = convertCurrencyToVND(productDetail!.price!) +
          "đ/${productDetail!.unit}";
    }
    return value;
  }

  int? getPrices() {
    if (unit == "THÙNG") {
      return productDetail!.price! * quantity! * productDetail!.changeValue!;
    } else {
      return productDetail!.price! * quantity!;
    }
  }

//  fromJson
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productDetail: ProductDetail.fromJson(json["productDetail"]),
        quantity: json["quantity"],
        unit: json["unit"],
        typeformVoucher: json["typeformVoucher"],
      );

//  Tojson
  Map<String, dynamic> toJson() {
    return {
      'productDetail': productDetail?.toJson(),
      'quantity': quantity,
      'unit': unit,
      'typeformVoucher': typeformVoucher,
    };
  }


//  Trường hợp 1. Nếu là thùng => Tính KM
//  Trường hợp 2. Nếu là khác Thùng => Số lượng / changeValue


//=> Có được số lượng để tính

//so sánh
//  => Nếu phần nguyên >=1 thì tính KM
//          Lấy vouchers from prod detail
//         chạy vòng lặp trong list voucher vừa lấy ra
// lấy số lượng mua / số lượng item trong voucher// Mua 4 thùng / số lượng 1 => 4
//  Lấy phần nguyên * số lượng km => Sp 1 = 4 * 1 = 4








}

class CartModel extends Equatable {
  final List<Cart> cart;

  const CartModel({this.cart = const <Cart>[]});

  int? getTotalPrice() {
    return cart.fold(0, (total, current) {
      if (current.unit == "THÙNG") {
        return total! +
            current.productDetail!.price! *
                current.quantity! *
                current.productDetail!.changeValue!;
      } else {
        return total! + current.productDetail!.price! * current.quantity!;
      }
    });
  }

  // get Total price by IdAgent
  int? totalPriceByIdAgent(int idAgent) {
    return cart.fold(0, (total, current) {
      if (current.productDetail!.idAgent == idAgent) {
        if (current.unit == "THÙNG") {
          return total! +
              current.productDetail!.price! *
                  current.quantity! *
                  current.productDetail!.changeValue!;
        } else {
          return total! + current.productDetail!.price! * current.quantity!;
        }
      } else {
        return total;
      }
    });
  }

  //Get Cart from ProductDetail
  Cart? getCartFromProductDetail(ProductDetail productDetail) {
    return cart.firstWhere((c) => c.productDetail!.code == productDetail.code,
        orElse: () => Cart(productDetail: null, quantity: 0));
  }

  Map productQuantity(List<Cart> cart) {
    var quantity = {};
    for (var c in cart) {
      if (!quantity.containsKey(c.productDetail)) {
        quantity[c] = 1;
      } else {
        quantity[c] += 1;
      }
    }
    print(quantity.keys.length);
    return quantity;
  }

  List<int?> get idAgents =>
      cart.map((c) => c.productDetail!.idAgent).toList().toSet().toList();

  CartModel getCartsByAgent(int idAgent) {
    var currentCart =
        cart.where((c) => c.productDetail!.idAgent == idAgent).toList();
    return CartModel(cart: currentCart);
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      "cart": cart.map((e) => e.toJson()).toList(),
    };
  }

  //fromJson
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'CartModel{cart: $cart}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [cart];






}
