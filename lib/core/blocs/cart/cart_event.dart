part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  // final List<Cart> carts;
  //
  // const LoadCart({required this.carts});
  //
  // @override
  // List<Object> get props => [carts];
}

class AddToCart extends CartEvent {
  final Cart cart;

  const AddToCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class UpdateCart extends CartEvent {
  final Cart cart;

  const UpdateCart(this.cart);

  @override
  List<Object> get props => [cart];
}



class RemoveFromCart extends CartEvent {
  final Cart cart;

  const RemoveFromCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class RemoveAllCart extends CartEvent {
}
