part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class LoadCheckout extends CheckoutEvent {
  // final String id;
  // final String token;
  //
  // LoadCheckoutEvent({@required this.id, @required this.token});
  //
  // @override
  // List<Object> get props => [id, token];
}

class CheckoutConfirm extends CheckoutEvent {
  final CheckoutModel checkoutModel;

  const CheckoutConfirm({required this.checkoutModel});

  @override
  List<Object> get props => [checkoutModel];
}
