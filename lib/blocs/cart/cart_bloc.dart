import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/models/cart/cart_model.dart';
import 'package:lixshop/models/models.dart';

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
      emit(const CartLoaded());
    } catch (e) {
      emit(CartError());
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        //Nếu tồn tại thì cập nhật, ngược lại thêm vào
        List<Cart> cart = (state as CartLoaded).cartModel.cart;
        List<Cart> currentCart = cart.isNotEmpty ? cart : [];

        Cart? cartItem = currentCart.firstWhere(
            (item) =>
                item.productDetail!.code == event.cart.productDetail!.code,
            orElse: () => Cart(productDetail: null, quantity: 0));

        if (cartItem.productDetail != null) {
          cartItem.quantity = cartItem.quantity! + event.cart.quantity!;
        } else {
          currentCart.add(event.cart);
        }

        emit(CartLoaded(cartModel: CartModel(cart: currentCart)));

        // emit(
        //   CartLoaded(
        //     cartModel: CartModel(
        //       cart: List.from((state as CartLoaded).cartModel.cart)
        //         ..add(event.cart),
        //     ),
        //   ),
        // );
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
      } on Exception {
        emit(CartError());
      }
    }
  }
}
