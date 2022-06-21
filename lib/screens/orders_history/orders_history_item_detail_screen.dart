import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lixshop/constants/contains.dart';
import 'package:lixshop/models/order/order.dart';
import 'package:lixshop/models/order/order_detail.dart';
import 'package:lixshop/screens/orders_history/constants/order_status.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';

class OrderHistoryItemDetailScreen extends StatefulWidget {
  final Order order;

  const OrderHistoryItemDetailScreen({Key? key, required this.order})
      : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _CartCard(order: widget.order),
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
                      padding: const EdgeInsets.all(4.0),
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
                              "Tổng ${widget.order.donHangDetailDTO2s!.length} sản phẩm"
                                  .text
                                  .xl
                                  .gray500
                                  .make(),
                              "${widget.order.tienhangDH}đ"
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
                              "Tạm tính".text.xl.gray500.make(),
                              "${widget.order.tienhangDH}đ"
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
                                  "Tổng tiền".text.xl2.black.bold.make(),
                                  " (đã có VAT)"
                                      .text
                                      .color(Vx.gray800.withOpacity(0.8))
                                      .xl
                                      .make(),
                                ],
                              ),
                              "${widget.order.tongtienDH}đ"
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Đơn hàng #${widget.order.idDH}".text.size(16).black.make(),
              Text("${widget.order.agentLixName}",
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Vx.green500))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 8.0, top: 8),
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
                  child: "${orderStatusMapReverse[widget.order.status]}"
                      .text
                      .green500
                      .size(10)
                      .bold
                      .sm
                      .make(),
                ),
              ),
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

class _CartCard extends StatelessWidget {
  final Order order;

  const _CartCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var item in order.donHangDetailDTO2s!)
            _CartItem(orderDetail: item),
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
        child: SizedBox(
          width: 150,
          height: 50,
          child: RaisedButton(
            onPressed: () {},
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
    );
  }
}

class _CartItem extends StatelessWidget {
  final OrderDetail orderDetail;

  const _CartItem({Key? key, required this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
      // height: 220-16,
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 309/510,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                              orderDetail.productImage!,
                            errorBuilder: (context, url, error) =>
                            const Icon(Icons.error),
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      16.widthBox,
                      SizedBox(
                        width: size.width * 0.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: RichText(
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: orderDetail.productName!,
                                    ),
                                    TextSpan(
                                      text:
                                      " x${orderDetail.quantityDetail?.toInt()} ${orderDetail.productUnit}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Vx.red700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            5.heightBox,
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: "".text.size(10).gray500.make(),
                                  ),
                                  // SizedBox(
                                  //   child: GestureDetector(
                                  //       onTap: () {
                                  //         Navigator.of(context).push(
                                  //           HeroDialogRoute(
                                  //               builder: (context) => Column(
                                  //                     children: [
                                  //                       Flexible(
                                  //                           child: Container(),
                                  //                           flex: 2),
                                  //                       const _DetailCartItemPopup(),
                                  //                     ],
                                  //                   ),
                                  //               fullscreenDialog: false),
                                  //         );
                                  //       },
                                  //       child:
                                  //           "Chi tiết".text.green500.xl.make()),
                                  // ),
                                ],
                              ),
                            ),
                            5.heightBox,
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  "${convertCurrencyToVND(orderDetail.priceDetail!.toInt())}đ/${orderDetail.productUnit}"
                                      .text
                                      .xl
                                      .size(10)
                                      .gray500
                                      .make(),
                                  "${convertCurrencyToVND(orderDetail.totalDetail!.toInt())}đ"
                                      .text
                                      .color(Vx.black.withOpacity(0.8))
                                      .bold
                                      .xl2
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Flexible(
                      //       child: SizedBox(
                      //         width: MediaQuery.of(context).size.width - 150,
                      //         child: RichText(
                      //           maxLines: 2,
                      //           overflow: TextOverflow.ellipsis,
                      //           text: TextSpan(
                      //               style: const TextStyle(
                      //                   color: Colors.black, fontSize: 18),
                      //               text: widget.cart.productDetail!.name
                      //                   .toString()),
                      //         ),
                      //       ),
                      //     ),
                      //     5.heightBox,
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width - 150,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           SizedBox(
                      //             child: widget.cart.unit == "THÙNG"
                      //                 ? "Thùng ${widget.cart.productDetail!.changeValue} ${widget.cart.productDetail!.unit!.toLowerCase()} x ${widget.cart.productDetail!.wunit!}"
                      //                 .text
                      //                 .gray500
                      //                 .make()
                      //                 : null,
                      //           ),
                      //           SizedBox(
                      //             child: GestureDetector(
                      //               // onTap: () {
                      //               //   Navigator.of(context).push(
                      //               //     HeroDialogRoute(
                      //               //         builder: (context) => Column(
                      //               //               children: [
                      //               //                 Flexible(
                      //               //                     child: Container(),
                      //               //                     flex: 2),
                      //               //                 const _DetailCartItemPopup(),
                      //               //               ],
                      //               //             ),
                      //               //         fullscreenDialog: false),
                      //               //   );
                      //               // },
                      //                 child: "".text.green500.xl.make()),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     5.heightBox,
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width - 150,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           "${widget.cart.getPricesChangeValue()}"
                      //               .text
                      //               .xl
                      //               .gray500
                      //               .make(),
                      //           "${convertCurrencyToVND(widget.cart.getPrices()!)}đ"
                      //               .text
                      //               .color(Vx.black.withOpacity(0.8))
                      //               .bold
                      //               .xl2
                      //               .make(),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 16.0, left: 4, right: 4, bottom: 0),
              //   child: SizedBox(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         ClipRRect(
              //           borderRadius: BorderRadius.circular(16),
              //           child: Image.network(
              //             orderDetail.productImage!,
              //             height: 80,
              //             fit: BoxFit.cover,
              //             errorBuilder: (context, error, stackTrace) {
              //               return const Icon(Icons.error);
              //             },
              //           ),
              //         ),
              //           16.widthBox,
              //         SizedBox(
              //           width: size.width * 0.6,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               SizedBox(
              //                 width: MediaQuery.of(context).size.width - 150,
              //                 child: RichText(
              //                   maxLines: 5,
              //                   overflow: TextOverflow.ellipsis,
              //                   text: TextSpan(
              //                     style: const TextStyle(
              //                         color: Colors.black, fontSize: 16),
              //                     children: [
              //                       TextSpan(
              //                         text: orderDetail.productName!,
              //                       ),
              //                       TextSpan(
              //                         text:
              //                             " x${orderDetail.quantityDetail?.toInt()} ${orderDetail.productUnit}",
              //                         style: const TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           color: Vx.red700,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               5.heightBox,
              //               SizedBox(
              //                 width: MediaQuery.of(context).size.width - 150,
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     SizedBox(
              //                       child: "".text.size(10).gray500.make(),
              //                     ),
              //                     // SizedBox(
              //                     //   child: GestureDetector(
              //                     //       onTap: () {
              //                     //         Navigator.of(context).push(
              //                     //           HeroDialogRoute(
              //                     //               builder: (context) => Column(
              //                     //                     children: [
              //                     //                       Flexible(
              //                     //                           child: Container(),
              //                     //                           flex: 2),
              //                     //                       const _DetailCartItemPopup(),
              //                     //                     ],
              //                     //                   ),
              //                     //               fullscreenDialog: false),
              //                     //         );
              //                     //       },
              //                     //       child:
              //                     //           "Chi tiết".text.green500.xl.make()),
              //                     // ),
              //                   ],
              //                 ),
              //               ),
              //               5.heightBox,
              //               SizedBox(
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     "${convertCurrencyToVND(orderDetail.priceDetail!.toInt())}đ/${orderDetail.productUnit}"
              //                         .text
              //                         .xl
              //                         .size(10)
              //                         .gray500
              //                         .make(),
              //                     "${convertCurrencyToVND(orderDetail.totalDetail!.toInt())}đ"
              //                         .text
              //                         .color(Vx.black.withOpacity(0.8))
              //                         .bold
              //                         .xl2
              //                         .make(),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              orderDetail.donHangDetailKmDTO2s!.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                width: size.width * 0.9,
                                child: Column(
                                  children: List.generate(
                                      orderDetail.donHangDetailKmDTO2s!.length,
                                      (index) {
                                    var item = orderDetail
                                        .donHangDetailKmDTO2s![index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.6,
                                          child: Text(
                                            item.nameProductDetailKm!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Vx.gray500,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        "${item.quantityDetailKm!.toInt()} ${item.unitDetailKm}"
                                            .text
                                            .italic
                                            .bold
                                            .size(12)
                                            .gray500
                                            .make(),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 16.0, left: 4, right: 4),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       const SizedBox(
              //         width: 120,
              //         height: 42,
              //         child: SizedBox(
              //           child: Text("Số lượng",
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.w600)),
              //         ),
              //       ),
              //       Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 8.0),
              //             child: Container(
              //               child: Text("x" + orderDetail.quantityDetail!.toInt().toString(),
              //                   style: const TextStyle(
              //                       fontSize: 18,
              //                       color: Vx.black)),
              //             ),
              //           ),
              //         ],
              //       ),
              //       //Cart icon
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

//Voucher
// class _DetailCartItemPopup extends StatelessWidget {
//   const _DetailCartItemPopup({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(16),
//       color: DesignCourseAppTheme.nearlyWhite,
//       child: Container(
//         constraints:
//             BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.5),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Column(
//             children: [
//               const _HeaderCartItemPopup(),
//               const Divider(),
//               const _DetailCartItemList().expand(),
//               const Divider(),
//               const _FooterCartItemPopup(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _HeaderCartItemPopup extends StatelessWidget {
//   const _HeaderCartItemPopup({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Column(
//         children: [
//           const SizedBox(
//             child: Center(
//                 child: Text("Chi tiết",
//                     style:
//                         TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
//           ),
//           4.heightBox,
//           const SizedBox(
//             child: Text(
//               "Các hình thức khuyến mãi của sản phẩm nhằm áp dụng để có thể tiết kiệm được một khoản chi phí.",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _FooterCartItemPopup extends StatelessWidget {
//   const _FooterCartItemPopup({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: Vx.green500,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(16.0),
//             ),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: DesignCourseAppTheme.nearlyBlue.withOpacity(0.5),
//                   offset: const Offset(1.1, 1.1),
//                   blurRadius: 10.0),
//             ],
//           ),
//           child: const Center(
//             child: Text(
//               'Đóng',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//                 letterSpacing: 0.0,
//                 color: DesignCourseAppTheme.nearlyWhite,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _DetailCartItemList extends StatefulWidget {
//   const _DetailCartItemList({Key? key}) : super(key: key);
//
//   @override
//   State<_DetailCartItemList> createState() => _DetailCartItemListState();
// }
//
// class _DetailCartItemListState extends State<_DetailCartItemList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 100,
//         itemBuilder: (context, index) => Container(
//               child: Text("$index"),
//             ));
//   }
// }
