import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/models/cart/cart_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/contains.dart';
import '../../core/core.dart';
import '../../utils/design_course_app_theme.dart';

class CartDetailScreen extends StatefulWidget {
  final int idNpp;

  const CartDetailScreen({Key? key, required this.idNpp}) : super(key: key);

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Nhà phân phối ${widget.idNpp}".text.black.make(),
            const Text("Địa chỉ giao hàng",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Vx.green500)),
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
      ),
      bottomNavigationBar: _bottomNavigation(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              return _buildCartDetail(
                  state.cartModel.getCartsByAgent(widget.idNpp));
            } else {
              return Container();
            }
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
          height: 120,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                CartModel cartModel =
                    state.cartModel.getCartsByAgent(widget.idNpp);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const Spacer(),
                        "${convertCurrencyToVND(cartModel.getTotalPrice()!)}đ"
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
                );
              }
              return Center(
                child: "Đang tải...".text.xl2.make(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCartDetail(CartModel cartModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: _CartCard(cartModel: cartModel),
        ),
      ],
    );
  }
}

class _CartCard extends StatelessWidget {
  final CartModel cartModel;

  const _CartCard({Key? key, required this.cartModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          for (var cart in cartModel.cart) _CartItem(cart: cart),
        ],
      ),
    );
  }
}

class _CartItem extends StatefulWidget {
  final Cart cart;

  const _CartItem({Key? key, required this.cart}) : super(key: key);

  @override
  State<_CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<_CartItem> {
  void increment(BuildContext context) {
    if (widget.cart.quantity! < 999) {
      widget.cart.quantity = widget.cart.quantity! + 1;
      context.read<CartBloc>().add(
            UpdateCart(
              widget.cart,
            ),
          );
      setState(() {});
    }
  }

  void decrement(BuildContext context) {
    if (widget.cart.quantity! > 1) {
      widget.cart.quantity = widget.cart.quantity! - 1;
      context.read<CartBloc>().add(
            UpdateCart(
              widget.cart,
            ),
          );
      setState(() {});
    }
  }

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
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            widget.cart.productDetail!.pathImg ??
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
                          Flexible(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    text: widget.cart.productDetail!.name
                                        .toString()),
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
                                  child: widget.cart.unit == "THÙNG"
                                      ? "Thùng ${widget.cart.productDetail!.changeValue} ${widget.cart.productDetail!.unit!.toLowerCase()} x ${widget.cart.productDetail!.wunit!}"
                                          .text
                                          .gray500
                                          .make()
                                      : null,
                                ),
                                SizedBox(
                                  child: GestureDetector(
                                      // onTap: () {
                                      //   Navigator.of(context).push(
                                      //     HeroDialogRoute(
                                      //         builder: (context) => Column(
                                      //               children: [
                                      //                 Flexible(
                                      //                     child: Container(),
                                      //                     flex: 2),
                                      //                 const _DetailCartItemPopup(),
                                      //               ],
                                      //             ),
                                      //         fullscreenDialog: false),
                                      //   );
                                      // },
                                      child: "".text.green500.xl.make()),
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
                                "${widget.cart.getPricesChangeValue()}"
                                    .text
                                    .xl
                                    .gray500
                                    .make(),
                                "${convertCurrencyToVND(widget.cart.getPrices()!)}đ"
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
                padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
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
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title:
                                    const Center(child: Text('Xác nhận xoá')),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Huỷ'),
                                    child: const Text('Huỷ'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(RemoveFromCart(widget.cart));
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
                            onTap: () {
                              decrement(context);
                            },
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
                              onFieldSubmitted: (value) {
                                widget.cart.quantity = int.parse(value);
                                context.read<CartBloc>().add(
                                      UpdateCart(widget.cart),
                                    );
                              },
                              textInputAction: TextInputAction.go,
                              controller: TextEditingController(
                                  text: widget.cart.quantity.toString()),
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
                          onTap: () => increment(context),
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
