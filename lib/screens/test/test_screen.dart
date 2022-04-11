import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/cart/cart_screen.dart';
import 'package:lixshop/screens/test/widgets/home_screen_body.dart';

import '../controller/sliver_scroll_controller.dart';
import 'constants.dart';
import 'controller/controllers.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    sliverScrollController.init();
    super.initState();
  }

  @override
  void dispose() {
    sliverScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CartScreen());
        },
        elevation: 0,
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: const HomeScreenBody(),
    );
  }
}
