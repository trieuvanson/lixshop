import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/blocs/cart/cart_bloc.dart';
import 'package:lixshop/repositories/checkout/checkout_repository.dart';

import '../blocs/checkout/checkout_bloc.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final CheckoutRepository _checkoutRepository = CheckoutRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  return IconButton(
                    icon: const Icon(
                      Icons.upload,
                    ),
                    onPressed: () {
                      _checkoutRepository.confirmCheckout(state.checkoutModel);
                    },

                  );
                }
                return Container(child: Text("data"),);
              },
            ),
          ],
        ),
      ),
    );
  }
}
