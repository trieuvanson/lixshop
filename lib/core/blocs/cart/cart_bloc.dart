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
        List<Cart> cart = (state as CartLoaded).cartModel.cart;
        var currentCartList = checkBeforeAdd(cart, event.cart);
        print('Aihihi');
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
        //Tăng bớt số lượng
        List<Cart> cart = (state as CartLoaded).cartModel.cart;
        var currentCartList = checkBeforeUpdate(cart, event.cart);
        cartController.saveCartToFileJson(currentCartList);
        emit(CartLoaded(cartModel: await cartController.readCartFromFileJson()));
      } catch (e) {
        print('Error: $e');
        emit(CartError(message: e.toString()));
      }
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        List<Cart> cart = List.from((state as CartLoaded).cartModel.cart)
          ..remove(event.cart);
        cartController.saveCartToFileJson(cart);
        emit(
          CartLoaded(
            cartModel: CartModel(
              cart: cart,
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
        cartController.saveCartToFileJson(cartModel.cart);
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



  List<Cart> checkBeforeAdd(List<Cart> carts, Cart current) {
    // print(current);
    List<Cart> currentCartList = carts.isNotEmpty ? carts : [];
    bool check = false;
    for (var item in carts) {
      if (item.typeformVoucher != -1) {
        if (item.productDetail!.code == current.productDetail!.code &&
            item.typeformVoucher == current.typeformVoucher &&
            item.unit == current.unit) {
          item.quantity = item.quantity! + current.quantity!;
          check = true;
          break;
        }
      } else {
        if (item.productDetail!.code == current.productDetail!.code &&
            item.unit == current.unit) {
          item.quantity = item.quantity! + current.quantity!;
          check = true;
          break;
        }
      }
    }

    if (!check) {
      currentCartList.add(current);
    }
    return currentCartList;
  }

  List<Cart> checkBeforeUpdate(List<Cart> carts, Cart current) {
    // print(current);
    List<Cart> currentCartList = carts.isNotEmpty ? carts : [];
    bool check = false;

    for (var item in carts) {
      if (item.productDetail!.code == current.productDetail!.code &&
          item.typeformVoucher == current.typeformVoucher &&
          item.unit == current.unit) {
        item.quantity = current.quantity!;
        check = true;
        break;
      }
    }
    print('check: $check');

    if (!check) {
      currentCartList.add(current);
    }
    return currentCartList;
  }
}
