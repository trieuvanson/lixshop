import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';

class CheckoutCardScreen extends StatefulWidget {
  const CheckoutCardScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutCardScreen> createState() => _CheckoutCardScreenState();
}

class _CheckoutCardScreenState extends State<CheckoutCardScreen>
    with TickerProviderStateMixin {
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
        title: "Đặt hàng".text.black.make(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.location_on_sharp,
                                        color: Vx.gray500, size: 30),
                                  ),
                                  SizedBox(
                                    child: "Địa chỉ nhận hàng"
                                        .text
                                        .xl2
                                        .bold
                                        .make(),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Vx.green700,
                                size: 20,
                              ),
                            ],
                          ),
                          10.heightBox,
                          "Tên người nhận".text.xl.bold.make(),
                          5.heightBox,
                          "Số điện thoại".text.xl.make(),
                          5.heightBox,
                          "Địa chỉ".text.xl.make(),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "Thêm ghi chú".text.green500.xl.make(),
                              //Icon ghi chú
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.edit,
                                color: Vx.green500,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              10.heightBox,
              Container(
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
                child: Column(
                  children: const [
                    _CheckoutItem(),
                    Divider(),
                    _CheckoutItem(),
                    Divider(),
                    _CheckoutItem(),
                    Divider(),
                    _CheckoutItem(),
                  ],
                ),
              ),
              10.heightBox,
              Container(
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
                              "Phụ phí giao hàng".text.xl.gray500.make(),
                              "Miễn phí"
                                  .text
                                  .color(Vx.green500)
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
                            children: [
                              "TỔNG TIỀN".text.xl.gray500.make(),
                              "9,000,000đ"
                                  .text
                                  .color(Vx.red700.withOpacity(0.8))
                                  .bold
                                  .xl2
                                  .make(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      const _PaymentItem(payment: "Tiền mặt", isSelected: true),
                      // 16.widthBox,
                      // const _PaymentItem(payment: "Chuyển khoản"),
                    ]
                  ),
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
                        onPressed: () {},
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: Vx.green500,
                        child: "Đặt hàng".text.white.bold.xl.make(),
                      ),
                    )
                    //CheckoutCard icon
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
                        Icons.add_shopping_CheckoutCard,
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

class _PaymentItem extends StatelessWidget {
  final String payment;
  final bool isSelected;

  const _PaymentItem({Key? key, required this.payment, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Vx.green500 : Vx.gray700,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                payment.text.bold.xl2.make(),
                SizedBox(
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Vx.green500,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const _BottomNavigationItem(
      {required this.title, required this.icon, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: isSelected ? Vx.blue500 : Vx.gray500,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Vx.blue500 : Vx.gray500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutItem extends StatelessWidget {
  const _CheckoutItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Vx.green200,
                  //       borderRadius: const BorderRadius.all(
                  //         Radius.circular(8.0),
                  //       ),
                  //       boxShadow: <BoxShadow>[
                  //         BoxShadow(
                  //             color: Vx.green50.withOpacity(0.5),
                  //             offset: const Offset(1.1, 1.1),
                  //             blurRadius: 8.0),
                  //       ],
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Center(
                  //           child:
                  //               "Giao lần 1".text.green500.xl.bold.make()),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    child: "Nhà phân phối ABC XYZ".text.xl.bold.make(),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Vx.green700,
                    size: 20,
                  ),
                ],
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var i = 0; i < 5; i++)
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                "https://picsum.photos/200",
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Giá sau ưu đãi".text.xl.gray500.make(),
                  "9,999,999đ"
                      .text
                      .color(Vx.red700.withOpacity(0.8))
                      .bold
                      .xl2
                      .make(),
                ],
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Phụ phí giao hàng".text.xl.gray500.make(),
                  "Miễn phí".text.color(Vx.green500).bold.xl2.make(),
                ],
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Giao từ".text.xl.gray500.make(),
                  "Tp. HCM, Dĩ An, Bình Dương.".text.xl.make(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: Vx.green200,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Dự kiến giao: Trước 22:00 ngày 11/03/2022"
                            .text
                            .xl
                            .make(),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Hẹn thời gian ".text.green500.xl.make(),
                            //Icon ghi chú
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.timer,
                              color: Vx.green500,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List paymentList = [
  "Tiền mặt",
  "Chuyển khoản",
];
