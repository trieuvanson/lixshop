

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../contains/contains.dart';
import '../../models/models.dart';
import '../../utils/design_course_app_theme.dart';
import '../../utils/hero_dialog_route.dart';
import '../screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {



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
      bottomNavigationBar: const _BottomNavigation(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            var cart = [];
            state.cartModel.cart
                .map((e) => {
                      if (!cart.contains(e.productDetail?.idAgent))
                        {cart.add(e.productDetail?.idAgent)}
                    })
                .toList();
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  for (var item in cart)
                    SizedBox(
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
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const CartDetailScreen(),
                                      curve: Curves.easeInToLinear,
                                    );
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.store_sharp,
                                                  color: Vx.gray500, size: 30),
                                            ),
                                            SizedBox(
                                              child: "Nhà phân phối ABC $item"
                                                  .text
                                                  .xl2
                                                  .bold
                                                  .make(),
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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

                          for (var cart in state.cartModel.cart)
                            Builder(builder: (_) {
                              print("CartModel: ${state.cartModel.cart}");
                              return _CartItem(cart: cart);
                            })
                          //Tạo biến ở phần thân của component
                          // for (var i = 0;
                          //     i <
                          //         state.cartModel
                          //             .productQuantity(state.cartModel.cart)
                          //             .keys
                          //             .length;
                          //     i++)
                          //   _CartItem(
                          //     product: state.cartModel
                          //         .productQuantity(state.cartModel.cart)
                          //         .keys
                          //         .elementAt(i),
                          //     quantity: state.cartModel
                          //         .productQuantity(state.cartModel.cart)
                          //         .values
                          //         .elementAt(i),
                          //   ),

                          // for (var product in state.cart.productDetail)
                          //   product.idAgent == item
                          //       ? _CartItem(
                          //           product: product,
                          //         )
                          //       : Container(),
                        ],
                      ),
                    ),

                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 16.0),
                  //   child: _CartCard(),
                  // ),
                ],
              ),
            );
          }
          if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// class _CartCard extends StatelessWidget {
//   const _CartCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//                 left: 8.0, right: 8.0, top: 12.0, bottom: 0.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.to(
//                       () => const CartDetailScreen(),
//                       curve: Curves.easeInToLinear,
//                     );
//                   },
//                   child: SizedBox(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.only(right: 8.0),
//                               child: Icon(Icons.store_sharp,
//                                   color: Vx.gray500, size: 30),
//                             ),
//                             SizedBox(
//                               child:
//                                   "Nhà phân phối ABC XYZ".text.xl2.bold.make(),
//                             ),
//                           ],
//                         ),
//                         const Icon(
//                           Icons.arrow_forward_ios,
//                           color: Vx.gray800,
//                           size: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       "Tổng tiền".text.xl.gray500.make(),
//                       "1,000,000đ"
//                           .text
//                           .color(Vx.red700.withOpacity(0.8))
//                           .bold
//                           .xl2
//                           .make(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           for (var i = 0; i < 5; i++) _CartItem(),
//         ],
//       ),
//     );
//   }
// }

class _BottomNavigation extends StatelessWidget {

  const _BottomNavigation({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Container(
            margin: MediaQuery.of(context).viewInsets,
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
                        "Tổng ${state.cartModel.cart.length} sản phẩm"
                            .text
                            .xl
                            .gray500
                            .make(),
                        "${state.cartModel.totalPriceVND}đ"
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
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
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
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text("Có lỗi xảy ra");
        }
      },
    );
  }
}

class _CartItem extends StatelessWidget {
  final Cart cart;

  const _CartItem({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cart);
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
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
                            cart.productDetail!.pathImg ??
                                "https://lzd-img-global.slatic.net/g/p/91154bf9a81671b7c88b928533bffcc1.png_200x200q80.jpg_.webp",
                            errorBuilder: (context, url, error) =>
                                const Icon(Icons.error),
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
                              width: MediaQuery.of(context).size.width - 150,
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    text: cart.productDetail!.name.toString()),
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
                                "${convertCurrencyToVND(cart.productDetail!.price!)}/${cart.unit}"
                                    .text
                                    .xl
                                    .gray500
                                    .make(),
                                "${convertCurrencyToVND(cart.productDetail!.price! * cart.quantity!)}đ"
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
                          child: InkWell(
                            child: SizedBox(
                              width: 30,
                              height: 30,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
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
                            child: TextFormField(
                              controller: TextEditingController(text: cart.quantity.toString()),
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
                        InkWell(
                          child: SizedBox(
                            width: 30,
                            height: 30,
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
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: DesignCourseAppTheme.nearlyWhite,
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.5),
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
        itemCount: 100, itemBuilder: (context, index) => Container());
  }
}
