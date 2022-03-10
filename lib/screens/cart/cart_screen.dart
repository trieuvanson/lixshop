import 'dart:math';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/contains/colors.dart';
import 'package:lixshop/screens/cart/checkout_card.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Giỏ hàng".text.black.make(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: _BottomNavigation(opacity3: opacity3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 2; i++)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: _CartCard(),
              ),
          ],
        ),
      ),
    );
  }
}


class _CartCard extends StatelessWidget {
  const _CartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 12.0, bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.store_sharp,
                              color: Vx.gray500, size: 30),
                        ),
                        SizedBox(
                          child: "Cửa hàng thứ n".text.xl2.bold.make(),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Vx.gray800,
                      size: 20,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tổng tiền".text.xl.gray500.make(),
                      "1,000,000đ"
                          .text
                          .color(Vx.red700.withOpacity(0.8))
                          .bold
                          .xl2
                          .make(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (var i = 0; i < 5; i++)
            const _CartItem(),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final double opacity3;

  const _BottomNavigation({Key? key, required this.opacity3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Tổng 10 sản phẩm".text.xl.gray500.make(),
                    "9,999,999đ"
                        .text
                        .color(Vx.black.withOpacity(0.8))
                        .bold
                        .xl2
                        .make(),
                  ],
                ),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Khuyến mãi đơn hàng".text.xl.gray500.make(),
                    "- 999,999đ"
                        .text
                        .color(Vx.green500.withOpacity(0.8))
                        .bold
                        .xl2
                        .make(),
                  ],
                ),
                5.heightBox,
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            "Tạm tính".text.xl2.black.bold.make(),
                            " (đã có VAT)"
                                .text
                                .color(Vx.gray800.withOpacity(0.8))
                                .xl
                                .make(),
                          ],
                        ),
                        "9,000,000đ"
                            .text
                            .color(Vx.red700.withOpacity(0.8))
                            .bold
                            .xl2
                            .make(),
                      ],
                    ),
                    // Button thanh toán
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          Get.to(
                                () => const CheckoutCardScreen(),
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: Vx.green500,
                        child: "Đặt hàng".text.white.bold.xl.make(),
                      ),
                    )
                    //Cart icon
                  ],
                ),
                /*  10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: DesignCourseAppTheme.nearlyWhite,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          border: Border.all(
                            color: Vx.green500,
                          )),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Vx.green500,
                        size: 28,
                      ),
                    ),
                    16.widthBox,
                    Expanded(
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: Vx.green500,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: DesignCourseAppTheme.nearlyBlue
                                    .withOpacity(0.5),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Thêm vào giỏ hàng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: DesignCourseAppTheme.nearlyWhite,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Vx.gray200.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: Vx.gray500.withOpacity(0.1)),
      ),
      width: MediaQuery.of(context).size.width,
      // height: 220-16,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 8),
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://picsum.photos/200",
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  16.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   child: "Nước rửa chén Lix Siêu"
                      //       .text
                      //       .xl
                      //       .make(),
                      // ),
                      Flexible(
                        child: SizedBox(
                          width:
                          MediaQuery.of(context).size.width  - 150,
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: const TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 18),
                                text:
                                'Nước rửa chén Lix hương chanh siêu sạch sạch sạch sạchsạch sạch sạch sạch'),
                          ),
                        ),
                      ),
                      5.heightBox,
                      SizedBox(
                        width:
                        MediaQuery.of(context).size.width  - 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child:
                              "Thùng 13 bịch x 12 gói x 25g".text.xl.gray500.make(),
                            ),
                            SizedBox(
                              child:
                              "Chi tiết".text.green500.xl.make(),
                            ),
                          ],
                        ),
                      ),
                      5.heightBox,
                      SizedBox(
                        width:
                        MediaQuery.of(context).size.width  - 150,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            "100,000đ/Thùng".text.xl.gray500.make(),
                            "100,000đ"
                                .text
                                .color(Vx.black.withOpacity(0.8))
                                .bold
                                .xl2
                                .make(),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  height: 42,
                  child: Center(
                    child: SizedBox(
                      child: RaisedButton(
                        onPressed: () {},
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: Vx.white,
                        child: "Xoá".text.gray600.bold.xl.make(),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                              color: DesignCourseAppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                color: Vx.green500,
                              )),
                          child: const Icon(
                            Icons.remove,
                            color: Vx.green500,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            border: Border.all(
                              color: Vx.green500,
                            )),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[+]?\d+([.]\d+)?$')),
                            //  Giới hạn 3 kí tự
                            LengthLimitingTextInputFormatter(3),
                          ],
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.only(bottom: 14.0),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: DesignCourseAppTheme.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            border: Border.all(
                              color: Vx.green500,
                            )),
                        child: const Icon(
                          Icons.add,
                          color: Vx.green500,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                //Cart icon
              ],
            ),
          ),
        ],
      ),
    );
  }
}

