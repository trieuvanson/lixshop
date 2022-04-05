part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}


class CheckoutLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutState {
  final CheckoutModel checkoutModel;

  const CheckoutLoaded({this.checkoutModel = const CheckoutModel()});
  @override
  List<Object> get props => [checkoutModel];
}

class CheckoutSuccess extends CheckoutState {
  final CheckoutModel checkoutModel;

  const CheckoutSuccess({this.checkoutModel = const CheckoutModel()});
  @override
  List<Object> get props => [checkoutModel];
}

class CheckoutError extends CheckoutState {
  final String error;

  const CheckoutError({this.error = 'Error'});

  @override
  List<Object> get props => [error];
}
