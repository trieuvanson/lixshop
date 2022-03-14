import 'dart:math';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/contains/colors.dart';
import 'package:lixshop/screens/cart/checkout_card_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';
import '../../utils/hero_dialog_route.dart';

class OrderHistoryItemDetailScreen extends StatefulWidget {
  const OrderHistoryItemDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryItemDetailScreen> createState() =>
      _OrderHistoryItemDetailScreenState();
}

class _OrderHistoryItemDetailScreenState
    extends State<OrderHistoryItemDetailScreen> with TickerProviderStateMixin {
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
      appBar: _appBar(),
      bottomNavigationBar: _BottomNavigation(opacity3: opacity3),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: _CartCard(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 8.0),
                  ],
                ),
                child: Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child:
                                    "Thông tin đơn hàng".text.xl2.bold.make(),
                              ),
                              Container()
                            ],
                          ),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Tổng 10 sản phẩm".text.xl.gray500.make(),
                              "1,000,000đ"
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
                              "- 100,000đ"
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
                              "900,000đ"
                                  .text
                                  .color(Vx.red700.withOpacity(0.8))
                                  .bold
                                  .xl2
                                  .make(),
                              // Button thanh toán
                              //Cart icon
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0.0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Đơn hàng #12412312".text.size(16).black.make(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Vx.green200,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Vx.green50.withOpacity(0.5),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: "Đang chờ xác nhận".text.green500.sm.make()),
                  ),
                ),
              ),
            ],
          ),
          const Text("Địa chỉ giao hàng",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Vx.green500))
        ],
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
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
          for (var i = 0; i < 5; i++) const _CartItem(),
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
            width: 150,
            height: 50,
            child: RaisedButton(
              onPressed: () {

              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              color: Vx.green500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon ban
                  const Icon(
                    Icons.block,
                    color: Colors.white,
                  ),
                  8.widthBox,
                  "Huỷ đơn hàng".text.white.bold.xl.make(),
                ],
              ),
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
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 8, right: 8, bottom: 0),
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
                          Flexible(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    text:
                                        'Nước rửa chén Lix hương chanh siêu sạch sạch sạch sạchsạch sạch sạch sạch'),
                              ),
                            ),
                          ),
                          5.heightBox,
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: "Thùng 13 bịch x 12 gói x 25g"
                                      .text
                                      .gray500
                                      .make(),
                                ),
                                SizedBox(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          HeroDialogRoute(
                                              builder: (context) => Column(
                                                    children: [
                                                      Flexible(
                                                          child: Container(),
                                                          flex: 2),
                                                      const _DetailCartItemPopup(),
                                                    ],
                                                  ),
                                              fullscreenDialog: false),
                                        );
                                      },
                                      child:
                                          "Chi tiết".text.green500.xl.make()),
                                ),
                              ],
                            ),
                          ),
                          5.heightBox,
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    16.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Khuyến mãi"
                                  .text
                                  .color(Vx.black.withOpacity(0.8))
                                  .bold
                                  .make(),
                              "".text.xl.gray500.make(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 250,
                                    child: const Text(
                                      "NRC Lix chanh 1,2kgNRC Lix chanh 1,2kgNRC Lix chanh 1,2kg",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Vx.gray500),
                                    ),
                                  ),
                                  "3 can".text.gray500.make(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 250,
                                    child: const Text(
                                      "NRC Lix chanh 1,2kgNRC Lix chanh 1,2kgNRC Lix chanh 1,2kg",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Vx.gray500),
                                    ),
                                  ),
                                  "3 can".text.gray500.make(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 250,
                                    child: const Text(
                                      "NRC Lix chanh 1,2kgNRC Lix chanh 1,2kgNRC Lix chanh 1,2kg",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Vx.gray500),
                                    ),
                                  ),
                                  "3 can".text.gray500.make(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 250,
                                    child: const Text(
                                      "NRC Lix chanh 1,2kgNRC Lix chanh 1,2kgNRC Lix chanh 1,2kg",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Vx.gray500),
                                    ),
                                  ),
                                  "3 can".text.gray500.make(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
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
                                contentPadding: EdgeInsets.only(bottom: 14.0),
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
        ),
      ),
    );
  }
}

//Voucher
class _DetailCartItemPopup extends StatelessWidget {
  const _DetailCartItemPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "null",
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: DesignCourseAppTheme.nearlyWhite,
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 1.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const _HeaderCartItemPopup(),
                const Divider(),
                const _DetailCartItemList().expand(),
                const Divider(),
                const _FooterCartItemPopup(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderCartItemPopup extends StatelessWidget {
  const _HeaderCartItemPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          const SizedBox(
            child: Center(
                child: Text("Chi tiết",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          ),
          4.heightBox,
          const SizedBox(
            child: Text(
              "Các hình thức khuyến mãi của sản phẩm nhằm áp dụng để có thể tiết kiệm được một khoản chi phí.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterCartItemPopup extends StatelessWidget {
  const _FooterCartItemPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Vx.green500,
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.nearlyBlue.withOpacity(0.5),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: const Center(
            child: Text(
              'Đóng',
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
      ),
    );
  }
}

class _DetailCartItemList extends StatefulWidget {
  const _DetailCartItemList({Key? key}) : super(key: key);

  @override
  State<_DetailCartItemList> createState() => _DetailCartItemListState();
}

class _DetailCartItemListState extends State<_DetailCartItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => Container(
              child: Text("$index"),
            ));
  }
}
