import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/controllers/cart/cart_controller.dart';
import 'package:lixshop/models/cart/cart_model.dart';
import 'package:lixshop/models/models.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartLoading()) {
    on<LoadCart>(_loadCart);
    on<AddToCart>(_addToCart);
    on<UpdateCart>(_updateCart);
    on<RemoveFromCart>(_removeFromCart);
    on<RemoveAllCart>(_removeAllCart);
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      emit(CartLoaded(cartModel: await cartController.readCartFromFileJson()));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        //Nếu tồn tại thì cập nhật, ngược lại thêm vào
        CartModel cart = await cartController.readCartFromFileJson();
        var currentCartList =
            cartController.checkBeforeAdd(cart.cart, event.cart);
        cartController.saveCartToFileJson(currentCartList);
        emit(CartLoaded(cartModel: CartModel(cart: [...currentCartList])));
      } catch (e) {
        print('Error: $e');
        emit(CartError(message: e.toString()));
      }
    }
  }

  void _updateCart(UpdateCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        CartModel cart = await cartController.readCartFromFileJson();

        var currentCartList =
            cartController.checkBeforeUpdate(cart.cart, event.cart);
        cartController.saveCartToFileJson(currentCartList);
        emit(CartLoaded(cartModel: CartModel(cart: [...currentCartList])));
      } catch (e) {
        print('Error Update: $e');
        emit(CartError(message: e.toString()));
      }
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        CartModel cart = await cartController.readCartFromFileJson();
        cartController.removeElementCart(event.cart, cart);
        emit(
          CartLoaded(
            cartModel: cart,
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
        cartController.saveCartToFileJson([]);
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
}
