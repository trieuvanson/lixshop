import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/blocs/cart/cart_bloc.dart';
import 'package:lixshop/repositories/checkout/checkout_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;

  CheckoutBloc({required CartBloc cartBloc})
      : _cartBloc = cartBloc,
        super(const CheckoutLoading()) {
    on<CheckoutConfirm>(_checkoutConfirm);
  }

  void _checkoutConfirm(
      CheckoutConfirm event, Emitter<CheckoutState> emit) async {
    final state = _cartBloc.state;
    try {
      if (state is CartLoaded) {
        emit(const CheckoutLoading());
        var cart = state.cartModel.cart;
        _saveCartToFileJson(_getCheckouts(cart));
        final response =
            await checkoutRepository.confirmCheckout(_getCheckouts(cart));
        if (response.err != 0) {
          emit(CheckoutError(error: response.msg!));
        } else {
          emit(CheckoutSuccess(checkoutModel: _getCheckouts(cart)));
        }
      }
    } catch (e) {
      emit(const CheckoutError(error: "Có lỗi xảy ra, vui lòng thử lại!"));
    }
  }

  CheckoutModel _getCheckouts(List<Cart> carts) {
    List<Checkout> checkout = [];
    for (var cart in carts) {
      checkout.add(
        Checkout(
          idAgent: cart.productDetail!.idAgent,
          price: cart.productDetail!.price,
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
    final contents2 = await file.readAsString();
    print(contents2);
  }
}
