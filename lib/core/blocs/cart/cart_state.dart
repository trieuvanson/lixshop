part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  final CartModel cartModel;

  const CartLoading({this.cartModel = const CartModel()});

  @override
  List<Object> get props => [cartModel];


}

class CartLoaded extends CartState {
  final CartModel cartModel;

  const CartLoaded({this.cartModel = const CartModel()});

  @override
  List<Object> get props => [cartModel];
}

class CartError extends CartState {
  final String message;

  const CartError({this.message = 'Error'});

  @override
  List<Object> get props => [message];
}
