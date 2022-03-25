part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Cart cart;

  const AddToCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class RemoveFromCart extends CartEvent {
  final Cart cart;

  const RemoveFromCart(this.cart);

  @override
  List<Object> get props => [cart];
}
