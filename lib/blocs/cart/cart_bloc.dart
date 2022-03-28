import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lixshop/models/cart/cart_model.dart';
import 'package:lixshop/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartLoading()) {
    on<LoadCart>(_loadCart);
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
    on<RemoveAllCart>(_removeAllCart);
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      emit(CartLoaded(cartModel: await _readCartFromFileJson()));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        //Nếu tồn tại thì cập nhật, ngược lại thêm vào
        List<Cart> cart = (state as CartLoaded).cartModel.cart;
        var currentCartList = checkBeforeAdd(cart, event.cart);
        _saveCartToFileJson(currentCartList);
        emit(CartLoaded(cartModel: CartModel(cart: currentCartList)));
        print("${(await _readCartFromFileJson())}");
      } on Exception {
        emit(const CartError());
      }
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cartModel: CartModel(
              cart: List.from((state as CartLoaded).cartModel.cart)
                ..remove(event.cart),
            ),
          ),
        );
      } on Exception catch (e) {
        print('Error: $e');
        emit(CartError(message: e.toString()));
      }
    }
  }

  void _removeAllCart(RemoveAllCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        CartModel cartModel = const CartModel(cart: []);
        _saveCartToFileJson(cartModel.cart);
        print(await _readCartFromFileJson());
        emit(
          CartLoaded(
            cartModel: cartModel,
          ),
        );
      } on Exception catch (e) {
        print('Error: $e');
        emit(CartError(message: e.toString()));
      }
    }
  }

  //extension ...

  void _saveCartToFileJson(List<Cart> cart) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    final contents = jsonEncode(CartModel(cart: cart).toJson());
    await file.writeAsString(contents.toString());
  }

  List<Cart> checkBeforeAdd(List<Cart> carts, Cart current) {
    // print(current);
    List<Cart> currentCartList = carts.isNotEmpty ? carts : [];
    bool check = false;

    for (var item in carts) {
      print('item: $item');
      print('item: ${item.typeformVoucher}');
      print('current: $current');
      print("curent: ${current.typeformVoucher}");
      print(current.typeformVoucher == item.typeformVoucher);
      if (item.productDetail!.code == current.productDetail!.code &&
          item.typeformVoucher == current.typeformVoucher &&
          item.unit == current.unit) {
        item.quantity = item.quantity! + current.quantity!;
        check = true;
        break;
      }
    }

    if (!check) {
      currentCartList.add(current);
    }
    // //
    // //
    // //
    // // print('cartItem: ${cartItem.toString()}');
    // // await Future.delayed(const Duration(seconds: 5));
    // //
    // //
    // //
    // // if (cartItem.productDetail != null) {
    // //   //  => Nếu tồn tại:
    // //   // =>: Kiểm tra hình thức khuyến mãi
    // //   bool checkTypeFormVoucher = carts
    // //       .firstWhere(
    // //           (element) =>
    // //       element.typeformVoucher ==
    // //           currentCart.typeformVoucher,
    // //       orElse: () => Cart())
    // //       .typeformVoucher !=
    // //       null;
    // //   //  =>: Nếu khuyến mãi trùng với sản phẩm đã có
    // //   if (checkTypeFormVoucher) {
    // //     //  =>: Kiểm tra đơn vị tính
    // //     print('Trùng mã khuyến mãi');
    // //     bool checkUnit = carts
    // //         .firstWhere((element) => element.unit == currentCart.unit,
    // //         orElse: () => Cart())
    // //         .unit !=
    // //         null;
    // //     // =>: Nếu đơn vị tính trùng hợp thì cập nhật số lượng
    // //     if (checkUnit) {
    // //       print('Trùng đơn vị');
    // //       cartItem.quantity = currentCart.quantity!;
    // //     } else {
    // //       print('Không trùng đơn vị');
    // //       // =>: không trùng thì thêm vào
    // //       cartItem.unit = currentCart.unit;
    // //       cartItem.quantity = currentCart.quantity!;
    // //       currentCartList.add(current);
    // //     }
    // //   } else {
    // //     print('Không trùng mã khuyến mãi');
    // //     //  =>: Nếu khuyến mãi không trùng với sản phẩm đã có
    // //     //  =>: Thêm vào
    // //     // cartItem.quantity = currentCart.quantity!;
    // //     currentCartList.add(current);
    // //   }
    // // } else {
    // //   print('Không tồn tại');
    // //   //  => Nếu không tồn tại:
    // //   // =>: Thêm vào
    // //   currentCartList.add(current);
    // // }
    return currentCartList;
  }

  Future<CartModel> _readCartFromFileJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    final contents1 = await file.readAsString();
    print('contents1: $contents1');
    if (file.existsSync()) {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      CartModel cartModel = CartModel.fromJson(json);
      return cartModel;
    }
    return const CartModel();
  }
}
// List<Cart> currentCartList = cart.isNotEmpty ? cart : [];
// Cart currentCart = event.cart;
// var cartItem = currentCartList.firstWhere(
//     (item) =>
//         item.productDetail!.code == currentCart.productDetail!.code,
//     orElse: () => Cart(productDetail: null, quantity: 0));
// //  Kiểm tra sản phẩm tồn tại hay chưa
// if (cartItem.productDetail != null) {
//   //  => Nếu tồn tại:
//   // =>: Kiểm tra hình thức khuyến mãi
//   bool checkTypeFormVoucher = cart
//           .firstWhere(
//               (element) =>
//                   element.typeformVoucher ==
//                   currentCart.typeformVoucher,
//               orElse: () => Cart())
//           .typeformVoucher !=
//       null;
//   //  =>: Nếu khuyến mãi trùng với sản phẩm đã có
//   if (checkTypeFormVoucher) {
//     //  =>: Kiểm tra đơn vị tính
//     print('Trùng mã khuyến mãi');
//     bool checkUnit = cart
//             .firstWhere((element) => element.unit == currentCart.unit,
//                 orElse: () => Cart())
//             .unit !=
//         null;
//     // =>: Nếu đơn vị tính trùng hợp thì cập nhật số lượng
//     if (checkUnit) {
//       print('Trùng đơn vị');
//       cartItem.quantity = currentCart.quantity!;
//     } else {
//       print('Không trùng đơn vị');
//       // =>: không trùng thì thêm vào
//       currentCartList.add(event.cart);
//     }
//   } else {
//     print('Không trùng mã khuyến mãi');
//     //  =>: Nếu khuyến mãi không trùng với sản phẩm đã có
//     //  =>: Thêm vào
//     // cartItem.quantity = currentCart.quantity!;
//     currentCartList.add(event.cart);
//   }
// } else {
//   print('Không tồn tại');
//   //  => Nếu không tồn tại:
//   // =>: Thêm vào
//   currentCartList.add(event.cart);
// }
// //Convert object to json and write to file
