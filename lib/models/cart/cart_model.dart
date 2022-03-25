import 'package:equatable/equatable.dart';
import 'package:lixshop/models/models.dart';

class Cart {
  final ProductDetail? productDetail;
  final int? quantity;

  const Cart({
    this.productDetail,
    this.quantity,
  });

  @override
  String toString() {
    return 'Cart{productDetail: $productDetail, quantity: $quantity}';
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


  @override
  String toString() {
    return 'CartModel{cart: $cart}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [cart];
}
