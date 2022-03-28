import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/blocs/cart/cart_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  StreamSubscription? _cartSubscription;

  CheckoutBloc({required CartBloc cartBloc})
      : _cartBloc = cartBloc,
        super(const CheckoutLoading()) {
    on<CheckoutConfirm>(_checkoutConfirm);
    _cartSubscription = cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
        }
      },
    );
  }

  void _checkoutConfirm(
      CheckoutConfirm event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoaded) {
      try {
        CheckoutModel checkoutModel = (state as CheckoutLoaded).checkoutModel;
        _saveCartToFileJson(checkoutModel);
        emit(CheckoutLoaded(checkoutModel: checkoutModel));
      } on Exception {
        emit(const CheckoutError());
      }
    }
  }

  CheckoutModel _getCheckouts(List<Cart> carts) {
    List<Checkout> checkout = [];
    for (var cart in carts) {
      checkout.add(
        Checkout(
          idAgent: cart.productDetail!.idAgent,
          productCode: cart.productDetail!.code,
          quantity: cart.quantity,
          unit: cart.unit,
          typeformVoucher: cart.typeformVoucher,
        ),
      );
    }
    return CheckoutModel(error: "", checkout: checkout);
  }

  void _saveCartToFileJson(CheckoutModel checkoutModel) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/checkout.json');
    final contents = jsonEncode(checkoutModel.toJson());
    await file.writeAsString(contents.toString());
    file.readAsString().then((value) {
      print(value);
    });
  }
}
