import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/cart/cart_screen.dart';
import 'constants.dart';
import 'widgets/home_screen_body.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CartScreen());
        },
        elevation: 0,
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: const HomeScreenBody(),
    );
  }
}
