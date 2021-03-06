import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/cart/cart_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'constants/constants.dart';
import 'widgets/home_screen_body.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CartScreen());
        },
        elevation: 0,
        backgroundColor: Vx.red700,
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: const HomeScreenBody(),
    );
  }
}
