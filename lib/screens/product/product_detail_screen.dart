import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/blocs/cart/cart_bloc.dart';
import 'package:lixshop/contains/contains.dart';
import 'package:lixshop/repositories/product/product_details_data_repository.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../utils/design_course_app_theme.dart';
import 'widget/widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;

  //Size

  @override
  void initState() {
    super.initState();
  }

  int amount = 0;
  int selectedTabbar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: FutureBuilder<ProductDetailsDataModel>(
        future:
            ProductDetailsDataRepository().getProductDetails(458, ["5", "233"]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != null &&
                snapshot.data!.error!.isNotEmpty) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _BuildProductDetailWidget(
              detailsDataModel: snapshot.data!,
              selectTabIndex: selectedTabbar,
            );
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.data!.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  //display error
  Widget _buildErrorWidget(dynamic error) {
    print('Error: $error');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Có lỗi xảy ra',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class _BuildProductDetailWidget extends StatefulWidget {
  final ProductDetailsDataModel detailsDataModel;
  int selectTabIndex;
  _BuildProductDetailWidget(
      {Key? key,
      required this.detailsDataModel,
      required this.selectTabIndex})
      : super(key: key);

  @override
  State<_BuildProductDetailWidget> createState() =>
      _BuildProductDetailWidgetState();
}

class _BuildProductDetailWidgetState extends State<_BuildProductDetailWidget> {
  int index = 0;
  var productDetails;
  var products;
  int selectProduct = 0;
  int selectVoucher = 1;
  List<String> emptyVoucherList = [];

  @override
  void initState() {
    productDetails = ProductDetailsRepository()
        .getProductDetails(widget.detailsDataModel, index);
    products = productDetails.productDetails;
    super.initState();
  }

  void changeProductSize(int index) {
    setState(() {
      this.index = index;

      productDetails = ProductDetailsRepository()
          .getProductDetails(widget.detailsDataModel, index);
      products = productDetails.productDetails;
      emptyVoucherList = [];
      selectVoucher = 1;
      selectProduct = changeProduct(selectProduct);
    });
  }

  int changeProduct(int selectVoucher) {
    for (var item in (products as List<ProductDetail>)) {
      for (var item2 in item.voucherMethods!) {
        if (item2.typeformCus == selectVoucher) {
          return products.indexOf(item);
        }
      }
    }
    return 0;
  }

  void changeVoucher(int index) {
    setState(() {
      selectVoucher = index;
      selectProduct = changeProduct(index);
    });
  }

  void checkEmptyVoucherList(ProductDetail productDetail) {
    if (!emptyVoucherList.contains(productDetail.code)) {
      emptyVoucherList.add(productDetail.code!);
    } else {
      print('Đã có trong danh sách');
    }
    print('Danh sách voucher: $emptyVoucherList');
    print('emptyVoucherList: ${emptyVoucherList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: _BottomNavigation(productDetails: products[selectProduct]),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ProductImage(
                  id: products[selectProduct].code,
                  img: products[selectProduct].pathImg ?? ""),
              Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                      child: Text(
                        products[selectProduct].name ?? "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 0.27,
                          color: DesignCourseAppTheme.darkerText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 8, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'đ${convertCurrencyToVND(products[selectProduct].price)}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: Vx.red700,
                            ),
                          ),
                          // SizedBox(
                          //   child: Row(
                          //     children: <Widget>[
                          //       RatingBarIndicator(
                          //         rating: double.parse(widget.rating),
                          //         itemBuilder: (context, index) => const Icon(
                          //           Icons.star,
                          //           color: Colors.yellow,
                          //         ),
                          //         itemCount: 5,
                          //         itemSize: 20.0,
                          //         unratedColor: Colors.amber.withAlpha(50),
                          //         direction: Axis.horizontal,
                          //       ),
                          //       Text(
                          //         widget.rating,
                          //         textAlign: TextAlign.left,
                          //         style: const TextStyle(
                          //           fontWeight: FontWeight.w200,
                          //           fontSize: 16,
                          //           letterSpacing: 0.27,
                          //           color: DesignCourseAppTheme.grey,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    10.heightBox,
                    //Size
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      "Chọn loại hàng ".text.bold.make(),
                                      "(${(products as List<ProductDetail>).length} sản phẩm)"
                                          .text
                                          .italic
                                          .make(),
                                    ],
                                  ),
                                ),
                                // 64.widthBox,
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var i = 0;
                                      i <
                                          widget
                                              .detailsDataModel
                                              .productDetailsData!
                                              .sizes!
                                              .length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: index == i
                                                ? Vx.green500
                                                : DesignCourseAppTheme
                                                    .nearlyWhite,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0)),
                                            border:
                                                Border.all(color: Vx.green500)),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor: Colors.white24,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0)),
                                            onTap: () {
                                              changeProductSize(i);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 8,
                                                  right: 8),
                                              child: Center(
                                                child: Text(
                                                  widget
                                                      .detailsDataModel
                                                      .productDetailsData!
                                                      .sizes![i],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    letterSpacing: 0.27,
                                                    color: index == i
                                                        ? Vx.white
                                                        : Vx.green500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.heightBox,
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            onTap: (index) {
                              setState(() {
                                widget.selectTabIndex = index;
                              });
                            },
                            physics: const BouncingScrollPhysics(),
                            isScrollable: true,
                            labelColor: Vx.green500,
                            unselectedLabelColor: Vx.gray500,
                            labelStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 3,
                                color: Vx.green500,
                              ),
                            ),
                            tabs: const [
                              Tab(text: "Khuyến mãi"),
                              Tab(text: "Thông tin sản phẩm"),
                            ],
                          ),
                          Builder(builder: (_) {
                            if (widget.selectTabIndex == 1) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: DesignCourseAppTheme.nearlyWhite,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: DesignCourseAppTheme.grey
                                            .withOpacity(0.2),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 12.0,
                                      bottom: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: "Thông tin chi tiết"
                                            .text
                                            .bold
                                            .make(),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Divider(
                                        color: DesignCourseAppTheme.grey
                                            .withOpacity(0.6),
                                        height: 1,
                                      ),
                                      for (var i = 0; i < 4; i++)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  'Tồn kho ${i + 1}',
                                                  style: const TextStyle(
                                                    color: DesignCourseAppTheme
                                                        .darkerText,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    136,
                                                child: Text(
                                                  "Đây là văn bản test $i",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const _ExpandAbleDescription(),
                                    ],
                                  ),
                                ),
                              ); //1st custom tabBarView
                            } else {
                              return _buildVoucher(
                                products[selectProduct],
                                products,
                                selectProduct,
                              ); //2nd tabView
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoucher(ProductDetail productDetail,
      List<ProductDetail> products, int selectedProduct) {
    var emptyVoucherProducts =
        products.where((element) => element.voucherMethods!.isEmpty).toList();
    var voucherProducts = products
        .where((element) => element.voucherMethods!.isNotEmpty)
        .toList();
    return Container(
      color: DesignCourseAppTheme.notWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightBox,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text("Lựa chọn hình thức khuyến mãi",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          emptyVoucherProducts.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, left: 12, right: 12, top: 12),
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        changeVoucher(-1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: selectVoucher == -1
                              ? Border.all(
                                  color: Vx.green500,
                                )
                              : null,
                          borderRadius: selectVoucher == -1
                              ? BorderRadius.circular(8.0)
                              : BorderRadius.circular(0.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: DesignCourseAppTheme.notWhite
                                    .withOpacity(0.2),
                                offset: const Offset(1.1, 1.1)),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Không sử dụng khuyến mãi"),
                                  selectVoucher == -1
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.check,
                                                color: Vx.green500,
                                                size: 16,
                                              ),
                                              Text(
                                                'Đang sử dụng',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Vx.green500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          for (var product in products)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Builder(builder: (_) {
                var vouchers = VoucherMethodRepository()
                    .getVoucherMethodsByProduct(product);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(builder: (_) {
                      return Column(
                        children: [
                          for (var voucher in vouchers.voucherMethods!)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 4, right: 4, top: 4),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    changeVoucher(voucher.typeformCus!);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          voucher.typeformCus == selectVoucher
                                              ? Border.all(
                                                  color: Vx.green500,
                                                )
                                              : null,
                                      borderRadius:
                                          voucher.typeformCus == selectVoucher
                                              ? BorderRadius.circular(8.0)
                                              : BorderRadius.circular(0.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: DesignCourseAppTheme.notWhite
                                                .withOpacity(0.2),
                                            offset: const Offset(1.1, 1.1)),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Hình thức ${voucher.typeformCus}',
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              //Sticker when click

                                              voucher.typeformCus ==
                                                      selectVoucher
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Row(
                                                        children: const [
                                                          Icon(
                                                            Icons.check,
                                                            color: Vx.green500,
                                                            size: 16,
                                                          ),
                                                          Text(
                                                            'Đang sử dụng',
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Vx.green500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ]),
                                        Builder(builder: (_) {
                                          var voucherDetails =
                                              VoucherMethodDetailsRepository()
                                                  .getVoucherMethodDetailsByMethod(
                                                      voucher);
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var detail in voucherDetails
                                                  .voucherMethodDetails!)
                                                Container(
                                                  width: MediaQuery.of(_)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4,
                                                          // left: 16,
                                                          // right: 16,
                                                          bottom: 4),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${detail.name}',
                                                            //
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            'Số lượng: ${detail.countValue?.toInt()}',
                                                            //
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Ghi chú: ${detail.wrap! ? 'Quấn kèm' : ''}',
                                                            //
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            'Điều kiện: Mua ${detail.value!.toInt()} thùng.',
                                                            //
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    })
                  ],
                );
              }),
            )
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String id;
  final String img;

  const _ProductImage({Key? key, required this.id, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        // color: appColor,
        child: Image.network(
          img,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Loading',
                  valueColor: AlwaysStoppedAnimation<Color>(Vx.black),
                ),
              ),
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    toolbarHeight: 40.0,
    backgroundColor: Colors.transparent,
    title: const Text(
      'Nước rửa chén thương hiệu Lixco',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.27,
        color: DesignCourseAppTheme.darkerText,
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      color: DesignCourseAppTheme.nearlyBlack,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.favorite_border,
          color: DesignCourseAppTheme.dark_grey,
        ),
        onPressed: () {},
      ),
      //share
      IconButton(
        icon: const Icon(
          Icons.shopping_cart,
          color: DesignCourseAppTheme.dark_grey,
        ),
        onPressed: () {},
      ),
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: const Icon(
            Icons.more_vert,
            color: DesignCourseAppTheme.dark_grey,
            size: 24,
          ),
          customItemsIndexes: const [3],
          customItemsHeight: 8,
          items: [
            ...MenuItems.firstItems.map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            ),
            const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
            ...MenuItems.secondItems.map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            ),
          ],
          onChanged: (value) {
            MenuItems.onChanged(context, value as MenuItem);
          },
          itemHeight: 48,
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownWidth: 200,
          dropdownPadding: const EdgeInsets.symmetric(vertical: 0),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          dropdownElevation: 8,
          offset: const Offset(0, 8),
        ),
      ),
    ],
  );
}

class _BottomNavigation extends StatelessWidget {
  final ProductDetail productDetails;

  const _BottomNavigation(
      {Key? key, required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
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
                ],
              ),
              16.widthBox,
              CustomDropdownButton2(
                buttonDecoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  border: Border.all(
                    color: Vx.green500,
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: Vx.green500,
                ),
                buttonWidth: 80,
                hint: 'Đơn vị tính',
                value: 'Gói',
                onChanged: (String? value) {},
                dropdownItems: const ["Gói", "Thùng"],
              ),
              16.widthBox,
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(0),
                      color: Vx.green500,
                      onPressed: () {
                        context.read<CartBloc>().add(AddToCart(Cart(
                            productDetail: productDetails, quantity: 1)));
                      },
                      child: const SizedBox(
                        height: 48,
                        // decoration: BoxDecoration(
                        //   color: Vx.green500,
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(8.0),
                        //   ),
                        //   boxShadow: <BoxShadow>[
                        //     BoxShadow(
                        //         color: DesignCourseAppTheme.nearlyBlue
                        //             .withOpacity(0.5),
                        //         offset: const Offset(1.1, 1.1),
                        //         blurRadius: 10.0),
                        //   ],
                        // ),
                        child: Center(
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
                    );
                  },
                ),
              )
              //Cart icon
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandAbleDescription extends StatelessWidget {
  const _ExpandAbleDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String abc =
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test";
    return SizedBox(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ExpandText(abc),
      ),
    );
  }
}
