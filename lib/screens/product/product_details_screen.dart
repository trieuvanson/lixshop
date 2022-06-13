import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/core/cubits/product_details/result_details_data_cubit.dart';
import 'package:lixshop/screens/cart/cart_screen.dart';
import 'package:lixshop/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/contains.dart';
import '../../controllers/controllers.dart';
import '../../core/core.dart';
import '../../models/models.dart';
import '../../utils/design_course_app_theme.dart';
import '../../utils/hero_dialog_route.dart';
import 'widget/menu_popup.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int idBrand;

  const ProductDetailsScreen({Key? key, required this.idBrand})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<ResultDetailsDataCubit>(context)
        .getProductOutside(widget.idBrand);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: BlocBuilder<ResultDetailsDataCubit, ResultDetailsDataState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _buildLoadingWidget();
          } else if (state.isError) {
            return _buildErrorWidget("Lỗi");
          } else if (state.isSuccess) {
            return BuildProductDetailWidget(
              resultDetailsDataModel: state.resultDetailsDataModel!,
            );
          }
          return Container();
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            error!.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class BuildProductDetailWidget extends StatefulWidget {
  final ResultDetailsDataModel resultDetailsDataModel;

  const BuildProductDetailWidget(
      {Key? key, required this.resultDetailsDataModel})
      : super(key: key);

  @override
  State<BuildProductDetailWidget> createState() =>
      _BuildProductDetailWidgetState();
}

class _BuildProductDetailWidgetState extends State<BuildProductDetailWidget> {
  late TextEditingController quantityController;
  int index = 0;
  late List<ProductDetail> products;
  int selectProduct = 0;
  int selectVoucher = 1;
  int selectTabIndex = 0;
  String selectProductEmptyVoucher = ""; // if product empty voucher
  var _cart = Cart(
      quantity: 1, unit: "THÙNG", typeformVoucherCustom: 1, typeformVoucher: 1);
  final productDetailsDataController = ProductDetailsDataController();
  int quantity = 1;

  @override
  void initState() {
    quantityController = TextEditingController(
      text: quantity.toString(),
    );
    products = productDetailsDataController.getProductDetails(
        widget.resultDetailsDataModel,
        widget.resultDetailsDataModel.sizes!.first);
    super.initState();
  }

  void changeProductSize(String size, int index) {
    setState(
      () {
        this.index = index;
        products = productDetailsDataController.getProductDetails(
            widget.resultDetailsDataModel, size);
        reset();
        selectVoucher = 1;
        selectProduct = changeProduct(selectProduct, selectProductEmptyVoucher);
        _cart.unit = "THÙNG";
      },
    );
  }

  void reset() {
    setState(
      () {
        _cart.quantity = 1;
      },
    );
  }

  int changeProduct(int selVoucher, String selectProductEmptyVoucher) {
    if (selectProductEmptyVoucher.isNotEmpty && selVoucher == -1) {
      for (var item in products) {
        if (item.code == selectProductEmptyVoucher) {
          return products.indexOf(item);
        }
      }
    } else {
      for (var item in products) {
        for (var item2 in item.voucherMethods!) {
          if (item2.typeformCus == selVoucher) {
            return products.indexOf(item);
          }
        }
      }
    }
    return 0;
  }

  void changeVoucher(
      int index, String selectProductEmptyVoucher, int typeFormVoucherCustom) {
    setState(
      () {
        selectVoucher = index;
        _cart.typeformVoucherCustom = typeFormVoucherCustom;
        reset();
        selectProduct = changeProduct(index, selectProductEmptyVoucher);
        if (selectProductEmptyVoucher.isNotEmpty) {
          _cart.productDetail = products[selectProduct];
        } else {}
      },
    );
  }

  increaseQuantity() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_cart.quantity! <= 999) {
      setState(
        () {
          quantity++;
          _cart.quantity = quantity;
          quantityController.text = quantity.toString();
        },
      );
    }
  }

  Future<void> decreaseQuantity() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (_cart.quantity! > 1) {
      setState(
        () {
          quantity--;
          _cart.quantity = quantity;
          quantityController.text = quantity.toString();
        },
      );
    }
  }

  void printOnClick(Cart cart, String unit, int productCode) {
    Map<String, dynamic> map = {
      "productIdAgent": cart.productDetail!.idAgent,
      "productCode": cart.productDetail!.code,
      "productVoucherCustomCode": cart.productDetail!.voucherMethods
          ?.firstWhere(
            (element) => element.typeformCus == selectVoucher,
            orElse: () => VoucherMethod(typeform: -1),
          )
          .typeform, //Mặc định
      "test": cart.getVoucherMethodFromProductDetail(
          cart.productDetail!, selectVoucher),
      "quantity": cart.quantity,
      "price": cart.productDetail!.price,
      "unit": unit,
      "total": cart.quantity! * cart.productDetail!.price!,
    };
    print(map);
  }

  @override
  void dispose() {
    quantityController.clear();
    quantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: _buildBottom(products[selectProduct]),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImage(products[selectProduct].code!,
                  products[selectProduct].pathImg ?? ""),
              Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
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
                    //Name
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
                    //Price
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 8, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _cart.unit != "THÙNG"
                                ? 'đ${convertCurrencyToVND(products[selectProduct].price!)}'
                                : 'đ${convertCurrencyToVND(products[selectProduct].price! * products[selectProduct].changeValue!)}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: Vx.red700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    //Size
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
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
                                      "(${(products).length} sản phẩm)"
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
                                          widget.resultDetailsDataModel.sizes!
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
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          border:
                                              Border.all(color: Vx.green500),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor: Colors.white24,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            onTap: index == i
                                                ? () {}
                                                : () {
                                                    changeProductSize(
                                                        widget
                                                            .resultDetailsDataModel
                                                            .sizes![i],
                                                        i);
                                                  },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 8,
                                                  right: 8),
                                              child: Center(
                                                child: Text(
                                                  widget.resultDetailsDataModel
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
                    _buildDefaultTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultTab() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            onTap: (index) {
              setState(
                () {
                  selectTabIndex = index;
                },
              );
            },
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            labelColor: Vx.green500,
            unselectedLabelColor: Vx.gray500,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          Builder(
            builder: (_) {
              if (selectTabIndex == 1) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildExpandAbleDescription(
                            products[index].description!),
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
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVoucher(ProductDetail productDetail,
      List<ProductDetail> products, int selectedProduct) {
    var emptyVoucherProducts =
        products.where((element) => element.voucherMethods!.isEmpty).toList();
    final voucherMethodController = VoucherController();
    return Container(
      color: DesignCourseAppTheme.notWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightBox,
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
                        // changeVoucher(-1);
                        Navigator.of(context).push(
                          HeroDialogRoute(
                            builder: (context) => Center(
                              child: _buildProductEmptyVoucherPopup(
                                  emptyVoucherProducts),
                            ),
                          ),
                        );
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
                              offset: const Offset(1.1, 1.1),
                            ),
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
                                  const Text(
                                    "Không sử dụng khuyến mãi",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Text(
              "Lựa chọn hình thức khuyến mãi",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          for (var product in products)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Builder(
                builder: (_) {
                  var vouchers = voucherMethodController
                      .getVoucherMethodsByProduct(product);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (_) {
                          return Column(
                            children: [
                              for (var voucher in vouchers)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 4, right: 4, top: 4),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        changeVoucher(voucher.typeformCus!, "",
                                            voucher.typeformCus!);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: voucher.typeformCus ==
                                                  selectVoucher
                                              ? Border.all(
                                                  color: Vx.green500,
                                                )
                                              : null,
                                          borderRadius: voucher.typeformCus ==
                                                  selectVoucher
                                              ? BorderRadius.circular(8.0)
                                              : BorderRadius.circular(0.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: DesignCourseAppTheme
                                                  .notWhite
                                                  .withOpacity(0.2),
                                              offset: const Offset(1.1, 1.1),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Hình thức ${voucher.typeformCus}',
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  //Sticker when click

                                                  voucher.typeformCus ==
                                                          selectVoucher
                                                      ? Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Row(
                                                            children: const [
                                                              Icon(
                                                                Icons.check,
                                                                color:
                                                                    Vx.green500,
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                'Đang sử dụng',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  color: Vx
                                                                      .green500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ]),
                                            Builder(
                                              builder: (_) {
                                                var voucherDetails =
                                                    voucherController
                                                        .getVoucherMethodDetailsByMethod(
                                                            voucher);
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (var detail
                                                        in voucherDetails)
                                                      Container(
                                                        width: MediaQuery.of(_)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              _)
                                                                          .size
                                                                          .width *
                                                                      0.7,
                                                                  child: Text(
                                                                    '${detail.name}',
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    //
                                                                    style: const TextStyle(
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .italic,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Số lượng: ${detail.countValue?.toInt()} ${detail.productVoucherUnit?.toLowerCase()}',
                                                                  //
                                                                  style: const TextStyle(
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  detail.wrap!
                                                                      ? 'Ghi chú: Quấn kèm'
                                                                      : "",
                                                                  //
                                                                  style: const TextStyle(
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontSize:
                                                                          10),
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
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }

  Widget _buildImage(String code, String img) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        // color: appColor,
        child: Image.network(
          img,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Vx.black),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      toolbarHeight: 40.0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Chi tiết sản phẩm',
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
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: DesignCourseAppTheme.darkGrey,
              ),
              onPressed: () {},
            );
          },
        ),
        //share
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: DesignCourseAppTheme.darkGrey,
          ),
          onPressed: () {
            Get.to(
              () => const CartScreen(),
            );
          },
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.more_vert,
              color: DesignCourseAppTheme.darkGrey,
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
              const DropdownMenuItem<Divider>(
                enabled: false,
                child: Divider(),
              ),
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

  Widget _buildBottom(ProductDetail productDetail) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        decreaseQuantity();
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
                            ),
                          ),
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
                        ),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          _cart.quantity = int.parse(value);
                          setState(
                            () {},
                          );
                          // print();
                        },
                        controller: quantityController,
                        onFieldSubmitted: (value) {
                          quantity = int.parse(value);
                          _cart.quantity = quantity;
                          setState(
                            () {},
                          );
                          // print();
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[+]?\d+([.]\d+)?$'),
                          ),
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
                    onTap: () {
                      increaseQuantity();
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
                          ),
                        ),
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
                buttonWidth: 120,
                hint: 'Đơn vị tính',
                value: _cart.unit,
                onChanged: (String? value) {
                  setState(
                    () {
                      _cart = Cart(quantity: 1, unit: value);
                    },
                  );
                },
                dropdownItems: [productDetail.unit ?? "CAN/CHAI/GÓI", "THÙNG"],
                dropdownWidth: 200,
              ),
              16.widthBox,
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(0),
                      color: Vx.green500,
                      onPressed: () {
                        _cart.productDetail = productDetail;
                        _cart.brandId = widget.resultDetailsDataModel.idBrand;
                        _cart.typeformVoucher =
                            _cart.getVoucherMethodFromProductDetail(
                                productDetail, selectVoucher);
                        _cart.voucherMethod =
                            _cart.getVoucherMethodFromProductDetailVoucher(
                                productDetail, selectVoucher);
                        BlocProvider.of<CartBloc>(context)
                            .add(AddToCart(_cart));

                        _cart.quantity = quantity;
                        showSnackBar("Thêm thành công", context);
                        setState(
                          () {},
                        );
                      },
                      child: const SizedBox(
                        height: 48,
                        child: Center(
                          child: Text(
                            'Thêm vào giỏ hàng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.0,
                              color: DesignCourseAppTheme.nearlyWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandAbleDescription(String? description) {
    return SizedBox(
        child: description!.isNotEmpty
            ? Card(
                clipBehavior: Clip.antiAlias,
                child: ExpandText(description),
              )
            : const Text("Đang cập nhật thông tin"));
  }

  Widget _buildProductEmptyVoucherPopup(
      List<ProductDetail> emptyVoucherProducts) {
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
              _buildVoucherList(emptyVoucherProducts).expand(),
              const Divider(),
              _buildFooterVoucher(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderVoucher() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          const SizedBox(
            child: Center(
                child: Text(
              "Khuyến mãi của sản phẩm",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
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

  Widget _buildFooterVoucher(BuildContext context) {
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

  Widget _buildVoucherList(List<ProductDetail> emptyVoucherProducts) {
    return ListView.builder(
      itemCount: emptyVoucherProducts.length,
      itemBuilder: (context, index) {
        ProductDetail product = emptyVoucherProducts[index];
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
            border: Border.all(
              color: Vx.gray500.withOpacity(0.1),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          // height: 220-16,
          child: Material(
            child: InkWell(
              onTap: () {},
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
                                product.pathImg ??
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
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  child: RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      text: product.name.toString(),
                                    ),
                                  ),
                                ),
                              ),
                              5.heightBox,
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 180,
                                child: SizedBox(
                                  child: "Thùng 13 bịch x 12 gói x 25g"
                                      .text
                                      .gray500
                                      .make(),
                                ),
                              ),
                              5.heightBox,
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 180,
                                child:
                                    "${convertCurrencyToVND(product.price!)}/Thùng"
                                        .text
                                        .xl
                                        .gray500
                                        .make(),
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
                              onPressed: () {
                                changeVoucher(-1, product.code!, -1);
                                Get.back();
                              },
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              color: Vx.white,
                              child:
                                  _cart.productDetail?.code == product.code &&
                                          _cart.typeformVoucherCustom! == -1
                                      ? "Đang chọn".text.red500.bold.xl.make()
                                      : "Chọn".text.gray600.bold.xl.make(),
                            )),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(right: 8.0),
                        //       child: SizedBox(
                        //         width: 40,
                        //         height: 40,
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               color: DesignCourseAppTheme.nearlyWhite,
                        //               borderRadius: const BorderRadius.all(
                        //                 Radius.circular(8.0),
                        //               ),
                        //               border: Border.all(
                        //                 color: Vx.green500,
                        //               ),),
                        //           child: const Icon(
                        //             Icons.remove,
                        //             color: Vx.green500,
                        //             size: 28,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(right: 8.0),
                        //       child: Container(
                        //         width: 48,
                        //         height: 48,
                        //         decoration: BoxDecoration(
                        //             color: DesignCourseAppTheme.nearlyWhite,
                        //             borderRadius: const BorderRadius.all(
                        //               Radius.circular(8.0),
                        //             ),
                        //             border: Border.all(
                        //               color: Vx.green500,
                        //             ),),
                        //         child: TextFormField(
                        //           inputFormatters: [
                        //             FilteringTextInputFormatter.allow(
                        //                 RegExp(r'^[+]?\d+([.]\d+)?$'),),
                        //             //  Giới hạn 3 kí tự
                        //             LengthLimitingTextInputFormatter(3),
                        //           ],
                        //           textAlignVertical: TextAlignVertical.center,
                        //           keyboardType: TextInputType.number,
                        //           textAlign: TextAlign.center,
                        //           decoration: InputDecoration(
                        //             hintText: '${cart.quantity}',
                        //             contentPadding:
                        //                 const EdgeInsets.only(bottom: 14.0),
                        //             border: InputBorder.none,
                        //             hintStyle: const TextStyle(
                        //               color: DesignCourseAppTheme.grey,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 40,
                        //       height: 40,
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //             color: DesignCourseAppTheme.nearlyWhite,
                        //             borderRadius: const BorderRadius.all(
                        //               Radius.circular(8.0),
                        //             ),
                        //             border: Border.all(
                        //               color: Vx.green500,
                        //             ),),
                        //         child: const Icon(
                        //           Icons.add,
                        //           color: Vx.green500,
                        //           size: 28,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        //Cart icon
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
