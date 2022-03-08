import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lixshop/responsive/mobile_screen_layout.dart';
import 'package:lixshop/widgets/text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

import '../contains/colors.dart';
import '../utils/utils.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: "Sản phẩm ABC".text.make(),
        // shadowColor: Colors.transparent,
        elevation: 0,
        // iconTheme: const IconThemeData(color: Vx.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Vx.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MobileScreenLayout(),
              settings: const RouteSettings(name: '/'),
            ));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 30),
            onPressed: () {
              /* Open the shopping cart */
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductImage(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: "Iron & Stone".text.xl2.make(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: "đ12.345".text.color(Vx.red600).xl.make(),
              ),
            ),

          ],
        ),
      ),
    );
  }

  buildProductImage(BuildContext context) {
    return SizedBox(
      // color: appColor,
      child:
      Image.asset('images/lix4.jpg', width: MediaQuery
          .of(context)
          .size
          .width,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Loading',
                  valueColor: AlwaysStoppedAnimation<Color>(Vx.black),
                ),
              ),
            );
          }, fit: BoxFit.cover),
    );
  }
}
