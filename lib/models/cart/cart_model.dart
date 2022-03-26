import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lixshop/models/models.dart';

class Cart {
  ProductDetail? productDetail;
  int? quantity;

  Cart({this.productDetail, this.quantity});

  @override
  String toString() {
    return 'Cart{productDetail: $productDetail, quantity: $quantity}';
  }

//  fromJson
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productDetail: ProductDetail.fromJson(json["productDetail"]),
        quantity: json["quantity"],
      );

//  Tojson
  Map<String, dynamic> toJson() {
    return {
      'productDetail': productDetail?.toJson(),
      'quantity': quantity,
    };
  }
}

class CartModel extends Equatable {
  final List<Cart> cart;

  const CartModel({this.cart = const <Cart>[]});

  // int get totalPrice => cart?.fold(0, (total, current) {
  //   return total + current.price!;
  // });
  int? get totalPrice => cart.fold(0, (total, current) {
        return total! + current.productDetail!.price! * current.quantity!;
      });

  //Convert VND currency
  String get totalPriceVND => totalPrice.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');

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

  //toJson
  Map<String, dynamic> toJson() {
    return {
      "cart": cart.map((e) => e.toJson()).toList(),
    };
  }

  //fromJson
  factory CartModel.fromJson(String json) {
    //Convert String to Map
    Map<String, dynamic> map = jsonDecode(json);
    return CartModel(
      cart: List<Cart>.from(map["cart"].map((x) => Cart.fromJson(x))),
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
