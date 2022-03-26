import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/models/cart/cart_model.dart';
import 'package:lixshop/models/models.dart';
import 'package:path_provider/path_provider.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    // on<CartEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<LoadCart>(_loadCart);
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/cart.json');
      // // RootObject rootObj= JsonConvert.DeserializeObject<RootObject>(File.ReadAllText(pathFile));
      //
      // final contents = await file.readAsString();
      // CartModel cart = CartModel.fromJson(json.decode(contents));
      emit(CartLoaded());
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        //Nếu tồn tại thì cập nhật, ngược lại thêm vào
        List<Cart> cart = (state as CartLoaded).cartModel.cart;
        List<Cart> currentCart = cart.isNotEmpty ? cart : [];
        var cartItem = currentCart.firstWhere(
            (item) =>
                item.productDetail!.code == event.cart.productDetail!.code,
            orElse: () => Cart(productDetail: null, quantity: 0));

        if (cartItem.productDetail != null) {
          cartItem.quantity = cartItem.quantity! + event.cart.quantity!;
        } else {
          currentCart.add(event.cart);
        }
        //Convert object to json and write to file

        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/cart.json');
        final contents = CartModel(cart: currentCart).toJson();
        await file.writeAsString(contents.toString());
        emit(CartLoaded(cartModel: CartModel(cart: currentCart)));

        //  Kiểm tra list có sản phẩm nào chưa
        //  Nếu chưa có thì Add => ok
        //  List có sản phẩm
        //  Kiểm tra xem list có tồn tại sản phẩm đó không
        //  Nếu có kiểm tra đvt
        //  Trùng thì cộng vào
        //  Không thì thêm vào
        //  Néu có tăng số lượng
        //  Chưa có thì thêm vào
        //  Có thì tăng số lượng

      } on Exception {
        emit(CartError());
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
}
