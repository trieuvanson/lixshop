import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../constants/contains.dart';
import 'package:lixshop/models/cart/cart_model.dart';
import 'package:lixshop/responsive/mobile_screen_layout.dart';
import 'package:lixshop/screens/cart/cart_detail_screen.dart';
import 'package:lixshop/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/core.dart';
import '../../utils/design_course_app_theme.dart';

class CheckoutCardScreen extends StatefulWidget {
  const CheckoutCardScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutCardScreen> createState() => _CheckoutCardScreenState();
}

class _CheckoutCardScreenState extends State<CheckoutCardScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;

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
      bottomNavigationBar: _bottomNavigation(),
      body: SingleChildScrollView(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              var idAgents = state.cartModel.idAgents;
              var cartModel = state.cartModel;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is SuccessAuthState) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          10.heightBox,
                                          "${state.user.name}"
                                              .text
                                              .xl
                                              .bold
                                              .make(),
                                          5.heightBox,
                                          "${state.user.phone}".text.xl.make(),
                                          5.heightBox,
                                          "${state.user.address}"
                                              .text
                                              .xl
                                              .make(),
                                          10.heightBox,
                                        ],
                                      );
                                    }
                                    return Container();
                                  },
                                ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Column(
                        children: [
                          for (var idNPP in idAgents)
                            _CheckoutItem(
                                idNPP: idNPP!,
                                cartModel: cartModel.getCartsByAgent(idNPP)),
                        ],
                      ),
                    ),
                    10.heightBox,
                    Container(
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: "Thông tin đơn hàng"
                                          .text
                                          .xl2
                                          .bold
                                          .make(),
                                    ),
                                    Container()
                                  ],
                                ),
                                10.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Tổng ${cartModel.cart.length} sản phẩm"
                                        .text
                                        .xl
                                        .gray500
                                        .make(),
                                    "${convertCurrencyToVND(cartModel.getTotalPrice()!)}đ"
                                        .text
                                        .color(Vx.black.withOpacity(0.8))
                                        .bold
                                        .xl2
                                        .make(),
                                  ],
                                ),
                                5.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    "TỔNG TIỀN".text.xl.gray500.make(),
                                    "${convertCurrencyToVND(cartModel.getTotalPrice()!)}đ"
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
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                            "${convertCurrencyToVND(state.cartModel.getTotalPrice()!)}đ"
                                .text
                                .color(Vx.red700.withOpacity(0.8))
                                .bold
                                .xl2
                                .make(),
                          ],
                        ),
                        // Button thanh toán
                        BlocListener<CheckoutBloc, CheckoutState>(
                          listener: (context, state) {
                            final cartBloc = BlocProvider.of<CartBloc>(context);
                            if (state is CheckoutSuccess) {
                              showSnackBar("Đặt hàng thành công!", context);
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MobileScreenLayout()),
                                    (route) => false);
                                cartBloc.add(RemoveAllCart());
                              });
                            } else if (state is CheckoutLoading) {
                              setState(() {
                                _isLoading = true;
                              });
                            } else if (state is CheckoutError) {
                              setState(() {
                                _isLoading = false;
                              });
                              showSnackBar(state.error, context);
                            }
                          },
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: RaisedButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Center(
                                      child: Text('Xác nhận đặt hàng')),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Huỷ'),
                                      child: const Text('Huỷ'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<CheckoutBloc>()
                                            .add(const CheckoutConfirm());
                                        Navigator.pop(context, 'Xác nhận');
                                      },
                                      child: const Text('Xác nhận'),
                                    ),
                                  ],
                                ),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              color: Vx.green500,
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Vx.white),
                                    )
                                  : "Đặt hàng".text.white.bold.xl.make(),
                            ),
                          ),
                        )
                        //CheckoutCard icon
                      ],
                    ),
                  ],
                );
              }
              return Container();
            },
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
  final int idNPP;
  final CartModel cartModel;

  const _CheckoutItem({Key? key, required this.idNPP, required this.cartModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => CartDetailScreen(idNpp: idNPP));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: "Nhà phân phối $idNPP".text.xl.bold.make(),
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
                      for (var item in cartModel.cart)
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                item.productDetail!.pathImg ?? "",
                                height: 80,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                },
                                errorBuilder: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
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
                  "${convertCurrencyToVND(cartModel.getTotalPrice()!)}đ"
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
