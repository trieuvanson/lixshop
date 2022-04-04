part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutEventLoaded extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class CheckoutConfirm extends CheckoutEvent {
  final CheckoutModel checkoutModel;

  const CheckoutConfirm({this.checkoutModel = const CheckoutModel()});

  @override
  List<Object> get props => [checkoutModel];
}
