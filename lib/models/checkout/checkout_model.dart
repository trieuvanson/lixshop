import 'package:equatable/equatable.dart';

import '../models.dart';

class Checkout {
  int? idAgent;
  String? productCode;
  int? quantity;
  String? unit;
  int? typeformVoucher;

  Checkout({
    this.idAgent,
    this.productCode,
    this.quantity,
    this.unit,
    this.typeformVoucher,
  });

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        idAgent: json["idAgent"],
        productCode: json["productCode"],
        quantity: json["quantity"],
        unit: json["unit"],
        typeformVoucher: json["typeformVoucher"],
      );

  Map<String, dynamic> toJson() => {
        "idAgent": idAgent,
        "productCode": productCode,
        "quantity": quantity,
        "unit": unit,
        "typeformVoucher": typeformVoucher,
      };
}

class CheckoutModel extends Equatable {
  final List<Checkout>? checkout;

  final String? error;

  const CheckoutModel({
    this.checkout,
    this.error,
  });

  CheckoutModel getCheckouts(List<Cart> carts) {
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
    return CheckoutModel(error: null, checkout: checkout);
  }

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        checkout: List<Checkout>.from(
            json["checkout"].map((x) => Checkout.fromJson(x))),
        error: "",
      );

  Map<String, dynamic> toJson() => {
        "checkout": checkout!.map((e) => e.toJson()).toList(),
        "error": error,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [checkout, error];
}
