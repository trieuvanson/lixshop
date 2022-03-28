part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}


class CheckoutLoading extends CheckoutState {
  final CheckoutModel checkoutModel;

  const CheckoutLoading({this.checkoutModel = const CheckoutModel()});

  @override
  List<Object> get props => [checkoutModel];
}

class CheckoutLoaded extends CheckoutState {
  final CheckoutModel checkoutModel;

  const CheckoutLoaded({this.checkoutModel = const CheckoutModel()});
  @override
  List<Object> get props => [checkoutModel];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError({this.message = 'Error'});

  @override
  List<Object> get props => [message];
}
