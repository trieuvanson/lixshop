import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/blocs/cart/cart_bloc.dart';
import 'package:lixshop/repositories/product/product_details_data_repository.dart';
import 'package:lixshop/repositories/product/product_sizes_repository.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../utils/design_course_app_theme.dart';
import '../../utils/hero_dialog_route.dart';
import '../order_history/order_history_item_detail_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  // final String id;
  // final String img;
  // final String title;
  // final String address;
  // final String rating;

  const ProductDetailScreen({
    Key? key,
    // required this.id,
    // required this.img,
    // required this.title,
    // required this.address,
    // required this.rating
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  //Size

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
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  int amount = 0;
  int _selectedTabar = 0;

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
              selectTabIndex: _selectedTabar,
              opacity3: opacity3,
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
  final double opacity3;

  _BuildProductDetailWidget(
      {Key? key,
      required this.detailsDataModel,
      required this.selectTabIndex,
      required this.opacity3})
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
      selectProduct = 0;
      productDetails = ProductDetailsRepository()
          .getProductDetails(widget.detailsDataModel, index);
      products = productDetails.productDetails;
    });
  }
  void changeProduct(int index) {
    setState(() {
      selectProduct = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: _BottomNavigation(
          opacity3: widget.opacity3, productDetails: products[selectProduct]),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ProductImage(id: products[selectProduct].code, img: products[selectProduct].pathImg??""),
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
                            'đ${products[selectProduct].price ?? ""}',
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
                                      "(1 sản phẩm, 4 hình thức)"
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var product in products)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: DesignCourseAppTheme.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
            child: Material(
              child: InkWell(
                onTap: () {
                  setState(() {
                    changeProduct(products.indexOf(product));
                  });
                  print(selectedProduct);
                  print('product: ${products.indexOf(product)}');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Builder(builder: (_) {
                      var vouchers = VoucherMethodRepository()
                          .getVoucherMethodsByProduct(product);
                      if (!vouchers.voucherMethods!.isNotEmpty) {
                        return Container(
                          width: MediaQuery.of(_).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16, bottom: 16),
                          child: const Text(
                            'Không có hình thức khuyến mãi nào',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var voucher in vouchers.voucherMethods!)
                            Container(
                              width: MediaQuery.of(_).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: DesignCourseAppTheme.grey
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16, bottom: 16),
                              child: Column(
                                children: [
                                  Text(
                                    'Hình thức ${voucher.typeform}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
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
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
                                              ),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: DesignCourseAppTheme
                                                        .grey
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 10.0),
                                              ],
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 16,
                                                left: 16,
                                                right: 16,
                                                bottom: 16),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${detail.name}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  '${detail.value}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
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
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
          )
      ],
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
  final double opacity3;
  final ProductDetail productDetails;

  const _BottomNavigation(
      {Key? key, required this.opacity3, required this.productDetails})
      : super(key: key);

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

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, reports];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Quay lại trang chủ', icon: Icons.home);
  static const share = MenuItem(text: 'Chia sẻ sản phẩm', icon: Icons.share);
  static const reports =
      MenuItem(text: 'Báo cáo sản phẩm', icon: Icons.bug_report_sharp);
  static const logout = MenuItem(text: 'Đăng xuất', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.reports:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}

// Widget _tabSection(BuildContext context) {
//   return DefaultTabController(
//     length: 2,
//     child: Column(
//       children: <Widget>[
//         const TabBar(
//           physics: BouncingScrollPhysics(),
//           isScrollable: true,
//           labelColor: Vx.green500,
//           unselectedLabelColor: Vx.gray500,
//           labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(
//               width: 3,
//               color: Vx.green500,
//             ),
//           ),
//           tabs: [
//             Tab(text: "Thông tin sản phẩm"),
//             Tab(text: "Khuyến mãi"),
//           ],
//         ),
//         SizedBox(
//           height: 310,
//           child: TabBarView(
//             children: [
//               SingleChildScrollView(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: DesignCourseAppTheme.nearlyWhite,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(8.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 8.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           child: "Thông tin chi tiết".text.bold.make(),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Divider(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.6),
//                           height: 1,
//                         ),
//                         for (var i = 0; i < 4; i++)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   width: 120,
//                                   child: Text(
//                                     'Tồn kho ${i + 1}',
//                                     style: const TextStyle(
//                                       color: DesignCourseAppTheme.darkerText,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width - 136,
//                                   child: Text(
//                                     "Đây là văn bản test $i",
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         const _ExpandAbleDescription(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: DesignCourseAppTheme.nearlyWhite,
//                   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                         color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                         offset: const Offset(1.1, 1.1),
//                         blurRadius: 8.0),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         child: "Thông tin chi tiết".text.bold.make(),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Divider(
//                         color: DesignCourseAppTheme.grey.withOpacity(0.6),
//                         height: 1,
//                       ),
//                       for (var i = 0; i < 4; i++)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 120,
//                                 child: Text(
//                                   'Tồn kho ${i + 1}',
//                                   style: const TextStyle(
//                                     color: DesignCourseAppTheme.darkerText,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width - 136,
//                                 child: Text(
//                                   "Đây là văn bản test $i",
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       const _ExpandAbleDescription(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
// Widget _buildProductDetailWidget(ProductDetailsDataModel detailsDataModel) {
//   return SizedBox(
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           // _ProductImage(id: widget.id, img: widget.img),
//           Container(
//             decoration: BoxDecoration(
//               color: DesignCourseAppTheme.nearlyWhite,
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(32.0),
//                   topRight: Radius.circular(32.0)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                     offset: const Offset(1.1, 1.1),
//                     blurRadius: 10.0),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(top: 16.0, left: 8, right: 8),
//                   child: Text(
//                     product.name ?? "",
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 22,
//                       letterSpacing: 0.27,
//                       color: DesignCourseAppTheme.darkerText,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 8, right: 8, bottom: 8, top: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'đ${product.price ?? ""}',
//                         textAlign: TextAlign.left,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           letterSpacing: 0.27,
//                           color: Vx.red700,
//                         ),
//                       ),
//                       // SizedBox(
//                       //   child: Row(
//                       //     children: <Widget>[
//                       //       RatingBarIndicator(
//                       //         rating: double.parse(widget.rating),
//                       //         itemBuilder: (context, index) => const Icon(
//                       //           Icons.star,
//                       //           color: Colors.yellow,
//                       //         ),
//                       //         itemCount: 5,
//                       //         itemSize: 20.0,
//                       //         unratedColor: Colors.amber.withAlpha(50),
//                       //         direction: Axis.horizontal,
//                       //       ),
//                       //       Text(
//                       //         widget.rating,
//                       //         textAlign: TextAlign.left,
//                       //         style: const TextStyle(
//                       //           fontWeight: FontWeight.w200,
//                       //           fontSize: 16,
//                       //           letterSpacing: 0.27,
//                       //           color: DesignCourseAppTheme.grey,
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 ),
//                 10.heightBox,
//                 //Size
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: DesignCourseAppTheme.nearlyWhite,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(8.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 8.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               child: Row(
//                                 children: [
//                                   "Chọn loại hàng ".text.bold.make(),
//                                   "(1 sản phẩm, 4 hình thức)"
//                                       .text
//                                       .italic
//                                       .make(),
//                                 ],
//                               ),
//                             ),
//                             // 64.widthBox,
//                             const Icon(
//                               Icons.arrow_forward_ios,
//                               size: 16,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               for (var i = 0;
//                                   i <
//                                       detailsDataModel
//                                           .productDetailsData!.sizes!.length;
//                                   i++)
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: index == i
//                                             ? Vx.green500
//                                             : DesignCourseAppTheme
//                                                 .nearlyWhite,
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(8.0)),
//                                         border:
//                                             Border.all(color: Vx.green500)),
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: InkWell(
//                                         splashColor: Colors.white24,
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(8.0)),
//                                         onTap: () {
//                                           index = i;
//                                           setState(() {});
//                                           print(index);
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8,
//                                               bottom: 8,
//                                               left: 8,
//                                               right: 8),
//                                           child: Center(
//                                             child: Text(
//                                               detailsDataModel
//                                                   .productDetailsData!
//                                                   .sizes![i],
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 14,
//                                                 letterSpacing: 0.27,
//                                                 color: index == i
//                                                     ? Vx.white
//                                                     : Vx.green500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // InkWell(
//                 //   onTap: () {
//                 //     Navigator.of(context).push(
//                 //       HeroDialogRoute(
//                 //           builder: (context) => Column(
//                 //                 children: [
//                 //                   Flexible(child: Container(), flex: 2),
//                 //                   const VoucherPopup(),
//                 //                 ],
//                 //               ),
//                 //           fullscreenDialog: false),
//                 //     );
//                 //   },
//                 //   child: Container(
//                 //     width: MediaQuery.of(context).size.width,
//                 //     decoration: BoxDecoration(
//                 //       color: DesignCourseAppTheme.nearlyWhite,
//                 //       borderRadius:
//                 //           const BorderRadius.all(Radius.circular(8.0)),
//                 //       boxShadow: <BoxShadow>[
//                 //         BoxShadow(
//                 //             color: DesignCourseAppTheme.grey
//                 //                 .withOpacity(0.2),
//                 //             offset: const Offset(1.1, 1.1),
//                 //             blurRadius: 8.0),
//                 //       ],
//                 //     ),
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.only(
//                 //           left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                 //       child: Column(
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: [
//                 //           Row(
//                 //             mainAxisAlignment:
//                 //                 MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               SizedBox(
//                 //                 child: "Khuyến mãi sản phẩm".text.make(),
//                 //               ),
//                 //               // 64.widthBox,
//                 //               const Icon(
//                 //                 Icons.arrow_forward_ios,
//                 //                 size: 16,
//                 //               ),
//                 //             ],
//                 //           ),
//                 //           const SizedBox(
//                 //             height: 8,
//                 //           ),
//                 //           Container(
//                 //             width: MediaQuery.of(context).size.width,
//                 //             alignment: Alignment.centerLeft,
//                 //             height: 20,
//                 //             decoration: BoxDecoration(
//                 //               color: Vx.green700.withOpacity(0.4),
//                 //             ),
//                 //             child: "Đang áp dụng hình thức 1"
//                 //                 .text
//                 //                 .gray700
//                 //                 .make(),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 10.heightBox,
//                 DefaultTabController(
//                   length: 2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TabBar(
//                         onTap: (index) {
//                           setState(() {
//                             _selectedTapbar = index;
//                           });
//                         },
//                         physics: const BouncingScrollPhysics(),
//                         isScrollable: true,
//                         labelColor: Vx.green500,
//                         unselectedLabelColor: Vx.gray500,
//                         labelStyle: const TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                         indicator: const UnderlineTabIndicator(
//                           borderSide: BorderSide(
//                             width: 3,
//                             color: Vx.green500,
//                           ),
//                         ),
//                         tabs: const [
//                           Tab(text: "Thông tin sản phẩm"),
//                           Tab(text: "Khuyến mãi"),
//                         ],
//                       ),
//                       Builder(builder: (_) {
//                         if (_selectedTapbar == 0) {
//                           return Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               color: DesignCourseAppTheme.nearlyWhite,
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(8.0)),
//                               boxShadow: <BoxShadow>[
//                                 BoxShadow(
//                                     color: DesignCourseAppTheme.grey
//                                         .withOpacity(0.2),
//                                     offset: const Offset(1.1, 1.1),
//                                     blurRadius: 8.0),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 8.0,
//                                   right: 8.0,
//                                   top: 12.0,
//                                   bottom: 12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     child:
//                                         "Thông tin chi tiết".text.bold.make(),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Divider(
//                                     color: DesignCourseAppTheme.grey
//                                         .withOpacity(0.6),
//                                     height: 1,
//                                   ),
//                                   for (var i = 0; i < 4; i++)
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 8.0),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                             width: 120,
//                                             child: Text(
//                                               'Tồn kho ${i + 1}',
//                                               style: const TextStyle(
//                                                 color: DesignCourseAppTheme
//                                                     .darkerText,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width -
//                                                 136,
//                                             child: Text(
//                                               "Đây là văn bản test $i",
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   const _ExpandAbleDescription(),
//                                 ],
//                               ),
//                             ),
//                           ); //1st custom tabBarView
//                         } else if (_selectedTapbar == 1) {
//                           return Container(); //2nd tabView
//                         } else {
//                           return Container(); //3rd tabView
//                         }
//                       }),
//                     ],
//                   ),
//                 ),
//
//                 //Đoạn này dành cho comment
//                 // 10.heightBox,
//                 /*  Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: DesignCourseAppTheme.nearlyWhite,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(8.0)),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               color:
//                                   DesignCourseAppTheme.grey.withOpacity(0.2),
//                               offset: const Offset(1.1, 1.1),
//                               blurRadius: 8.0),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   child:
//                                       "Đoạn này là comment".text.bold.make(),
//                                 ),
//                                 Row(
//                                   children: [
//                                     "Xem tất cả".text.green600.make(),
//                                     const Icon(
//                                       Icons.arrow_forward_ios,
//                                       color: Vx.green600,
//                                       size: 16,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),*/
//                 //Đoạn này dành cho các sản phẩm cùng loại(Bột giặt, nước giặt,...)
//                 // 10.heightBox,
//                 10.heightBox,
//                 //Sản phẩm tương tự (Hương chanh, hương bưởi...)
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: DesignCourseAppTheme.nearlyWhite,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(8.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 8.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               child: "Sản phẩm tương tự".text.bold.make(),
//                             ),
//                             Row(
//                               children: [
//                                 "Xem tất cả".text.green600.make(),
//                                 const Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: Vx.green600,
//                                   size: 16,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: List.generate(
//                                 6,
//                                 (index) => Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Container(
//                                         width: 100,
//                                         height: 140,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color:
//                                                   Vx.gray700.withOpacity(0.2),
//                                               width: 1),
//                                           borderRadius: const BorderRadius
//                                                   .only(
//                                               topLeft: Radius.circular(16),
//                                               topRight: Radius.circular(8),
//                                               bottomLeft: Radius.circular(8),
//                                               bottomRight:
//                                                   Radius.circular(8)),
//                                           boxShadow: <BoxShadow>[
//                                             BoxShadow(
//                                                 color: DesignCourseAppTheme
//                                                     .grey
//                                                     .withOpacity(0.2),
//                                                 offset:
//                                                     const Offset(1.1, 1.1),
//                                                 blurRadius: 8.0),
//                                           ],
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             // ClipRRect(
//                                             //   borderRadius:
//                                             //       const BorderRadius.only(
//                                             //     topLeft:
//                                             //         Radius.circular(16.0),
//                                             //   ),
//                                             //   child: Image.network(
//                                             //     widget.img,
//                                             //     width: double.infinity,
//                                             //     height: 80,
//                                             //     fit: BoxFit.cover,
//                                             //   ),
//                                             // ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 4.0,
//                                                   left: 4,
//                                                   right: 8),
//                                               child: Text(
//                                                 productDetails
//                                                         .productDetails![0]
//                                                         .name ??
//                                                     "",
//                                                 overflow:
//                                                     TextOverflow.ellipsis,
//                                                 maxLines: 2,
//                                                 textAlign: TextAlign.left,
//                                                 style: const TextStyle(
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 12,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             Flexible(child: Container()),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 4.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 4),
//                                                     child: Text(
//                                                       "đ ${productDetails.productDetails![0].price ?? ""}",
//                                                       style: const TextStyle(
//                                                         fontSize: 15,
//                                                         letterSpacing: 0.27,
//                                                         color: Vx.red600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 /*      Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: DesignCourseAppTheme.nearlyWhite,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(8.0)),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               color:
//                                   DesignCourseAppTheme.grey.withOpacity(0.2),
//                               offset: const Offset(1.1, 1.1),
//                               blurRadius: 8.0),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               child: "Có thể bạn cần".text.bold.make(),
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             AlignedGridView.count(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 4,
//                               shrinkWrap: true,
//                               physics: const ScrollPhysics(),
//                               crossAxisSpacing: 8,
//                               itemBuilder: (context, index) {
//                                 Map restaurant = restaurants.filter((element) => element['id'] != widget.id).toList()[index];
//                                 return ProductCardItem(
//                                   id: restaurant['id'],
//                                   img: restaurant['img'],
//                                   title: restaurant['title'],
//                                   address: restaurant['address'],
//                                   rating: restaurant['rating'],
//                                 );
//                               },
//                               itemCount: restaurants.length-1,
//
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),*/
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

/*
//Voucher
class VoucherPopup extends StatelessWidget {
  const VoucherPopup({Key? key}) : super(key: key);

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
              const _HeaderVoucher(),
              const Divider(),
              const _VoucherList().expand(),
              const Divider(),
              const _FooterVoucher(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderVoucher extends StatelessWidget {
  const _HeaderVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          const SizedBox(
            child: Center(
                child: Text("Khuyến mãi của sản phẩm",
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

class _FooterVoucher extends StatelessWidget {
  const _FooterVoucher({Key? key}) : super(key: key);

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

class _VoucherList extends StatefulWidget {
  const _VoucherList({Key? key}) : super(key: key);

  @override
  State<_VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<_VoucherList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100, itemBuilder: (context, index) => Container());
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
        onTap: () {
          Get.to(
            () => const OrderHistoryItemDetailScreen(),
            curve: Curves.easeInToLinear,
            transition: Transition.rightToLeft,
          );
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
                    child: "Đơn hàng #12412312".text.xl.bold.make(),
                  ),
                  Row(
                    children: [
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
                                child: "Đang chờ xác nhận"
                                    .text
                                    .green500
                                    .bold
                                    .make()),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Vx.green700,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Đặt vào ngày 20/10/2020".text.gray500.make(),
                  "9,999,999đ"
                      .text
                      .color(Vx.red700.withOpacity(0.8))
                      .bold
                      .xl
                      .make(),
                ],
              ),
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
              const Divider(
                color: Vx.gray500,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
//Đoạn này những cái lược bỏ, có thể sẽ cần

// InkWell(
//   onTap: () {
//     Navigator.of(context).push(
//       HeroDialogRoute(
//           builder: (context) => Column(
//                 children: [
//                   Flexible(child: Container(), flex: 2),
//                   const VoucherPopup(),
//                 ],
//               ),
//           fullscreenDialog: false),
//     );
//   },
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     decoration: BoxDecoration(
//       color: DesignCourseAppTheme.nearlyWhite,
//       borderRadius:
//           const BorderRadius.all(Radius.circular(8.0)),
//       boxShadow: <BoxShadow>[
//         BoxShadow(
//             color: DesignCourseAppTheme.grey
//                 .withOpacity(0.2),
//             offset: const Offset(1.1, 1.1),
//             blurRadius: 8.0),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.only(
//           left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 child: "Khuyến mãi sản phẩm".text.make(),
//               ),
//               // 64.widthBox,
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             alignment: Alignment.centerLeft,
//             height: 20,
//             decoration: BoxDecoration(
//               color: Vx.green700.withOpacity(0.4),
//             ),
//             child: "Đang áp dụng hình thức 1"
//                 .text
//                 .gray700
//                 .make(),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
/*
                    //Đoạn này dành cho comment
                    // 10.heightBox,
                    */
/*  Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color:
                                      DesignCourseAppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child:
                                          "Đoạn này là comment".text.bold.make(),
                                    ),
                                    Row(
                                      children: [
                                        "Xem tất cả".text.green600.make(),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Vx.green600,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),*/
/*
                    //Đoạn này dành cho các sản phẩm cùng loại(Bột giặt, nước giặt,...)
                    // 10.heightBox,
                    10.heightBox,
                    //Sản phẩm tương tự (Hương chanh, hương bưởi...)
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //     color: DesignCourseAppTheme.nearlyWhite,
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(8.0)),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //           color: DesignCourseAppTheme.grey.withOpacity(0.2),
                    //           offset: const Offset(1.1, 1.1),
                    //           blurRadius: 8.0),
                    //     ],
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             SizedBox(
                    //               child: "Sản phẩm tương tự".text.bold.make(),
                    //             ),
                    //             Row(
                    //               children: [
                    //                 "Xem tất cả".text.green600.make(),
                    //                 const Icon(
                    //                   Icons.arrow_forward_ios,
                    //                   color: Vx.green600,
                    //                   size: 16,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 8,
                    //         ),
                    //         SingleChildScrollView(
                    //           scrollDirection: Axis.horizontal,
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: List.generate(
                    //                 6,
                    //                 (index) => Padding(
                    //                       padding:
                    //                           const EdgeInsets.only(right: 8.0),
                    //                       child: Container(
                    //                         width: 100,
                    //                         height: 140,
                    //                         decoration: BoxDecoration(
                    //                           color: Colors.white,
                    //                           border: Border.all(
                    //                               color:
                    //                                   Vx.gray700.withOpacity(0.2),
                    //                               width: 1),
                    //                           borderRadius: const BorderRadius
                    //                                   .only(
                    //                               topLeft: Radius.circular(16),
                    //                               topRight: Radius.circular(8),
                    //                               bottomLeft: Radius.circular(8),
                    //                               bottomRight:
                    //                                   Radius.circular(8)),
                    //                           boxShadow: <BoxShadow>[
                    //                             BoxShadow(
                    //                                 color: DesignCourseAppTheme
                    //                                     .grey
                    //                                     .withOpacity(0.2),
                    //                                 offset:
                    //                                     const Offset(1.1, 1.1),
                    //                                 blurRadius: 8.0),
                    //                           ],
                    //                         ),
                    //                         child: Column(
                    //                           children: [
                    //                             // ClipRRect(
                    //                             //   borderRadius:
                    //                             //       const BorderRadius.only(
                    //                             //     topLeft:
                    //                             //         Radius.circular(16.0),
                    //                             //   ),
                    //                             //   child: Image.network(
                    //                             //     widget.img,
                    //                             //     width: double.infinity,
                    //                             //     height: 80,
                    //                             //     fit: BoxFit.cover,
                    //                             //   ),
                    //                             // ),
                    //                             Padding(
                    //                               padding: const EdgeInsets.only(
                    //                                   top: 4.0,
                    //                                   left: 4,
                    //                                   right: 8),
                    //                               child: Text(
                    //                                 productDetails
                    //                                         .productDetails![0]
                    //                                         .name ??
                    //                                     "",
                    //                                 overflow:
                    //                                     TextOverflow.ellipsis,
                    //                                 maxLines: 2,
                    //                                 textAlign: TextAlign.left,
                    //                                 style: const TextStyle(
                    //                                   fontWeight: FontWeight.w400,
                    //                                   fontSize: 12,
                    //                                   color: Colors.black,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Flexible(child: Container()),
                    //                             Padding(
                    //                               padding: const EdgeInsets.only(
                    //                                   bottom: 4.0),
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment.center,
                    //                                 children: [
                    //                                   Padding(
                    //                                     padding:
                    //                                         const EdgeInsets.only(
                    //                                             left: 4),
                    //                                     child: Text(
                    //                                       "đ ${productDetails.productDetails![0].price ?? ""}",
                    //                                       style: const TextStyle(
                    //                                         fontSize: 15,
                    //                                         letterSpacing: 0.27,
                    //                                         color: Vx.red600,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     )).toList(),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    */
/*      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color:
                                      DesignCourseAppTheme.grey.withOpacity(0.2),
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
                                SizedBox(
                                  child: "Có thể bạn cần".text.bold.make(),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                AlignedGridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  crossAxisSpacing: 8,
                                  itemBuilder: (context, index) {
                                    Map restaurant = restaurants.filter((element) => element['id'] != widget.id).toList()[index];
                                    return ProductCardItem(
                                      id: restaurant['id'],
                                      img: restaurant['img'],
                                      title: restaurant['title'],
                                      address: restaurant['address'],
                                      rating: restaurant['rating'],
                                    );
                                  },
                                  itemCount: restaurants.length-1,

                                ),
                              ],
                            ),
                          ),
                        ),*/
