import 'dart:math';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/restaurants.dart';
import '../../utils/design_course_app_theme.dart';
import '../../utils/hero_dialog_route.dart';
import '../../widgets/product_card_item.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _appBar(context),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: _BottomNavigation(opacity3: opacity3),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _ProductImage(),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
                        child: Text(
                          'Nước rửa chén thương hiệu Lixco',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                            const Text(
                              'VNĐ 12.345',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: Vx.red700,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: <Widget>[
                                  RatingBarIndicator(
                                    rating: 4.9,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    unratedColor: Colors.amber.withAlpha(50),
                                    direction: Axis.horizontal,
                                  ),
                                  const Text(
                                    ' 4.9',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            HeroDialogRoute(
                                builder: (context) => Column(
                                      children: [
                                        Flexible(child: Container(), flex: 2),
                                        const _Voucher_Popup(),
                                      ],
                                    ),
                                fullscreenDialog: false),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
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
                                left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: "Khuyến mãi sản phẩm".text.make(),
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
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Vx.green700.withOpacity(0.4),
                                  ),
                                  child: "Đang áp dụng hình thức 1"
                                      .text
                                      .gray700
                                      .make(),
                                ),
                              ],
                            ),
                          ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    for (var i = 0; i < 10; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: DesignCourseAppTheme
                                                  .nearlyWhite,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                              border: Border.all(
                                                  color: Vx.green500)),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              splashColor: Colors.white24,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                              onTap: () {
                                                print('Tap ${++i}');
                                                setState(() {
                                                  // categoryType = categoryTypeData;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 8,
                                                    left: 8,
                                                    right: 8),
                                                child: Center(
                                                  child: Text(
                                                    "Size ${i + 1}",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      letterSpacing: 0.27,
                                                      color: Vx.green500,
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
                      //Sản phẩm tương tự (Hương chanh, hương bưởi...)
                      Container(
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
                                    child: "Sản phẩm tương tự".text.bold.make(),
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      6,
                                      (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Container(
                                              width: 100,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Vx.gray700
                                                        .withOpacity(0.2),
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(16),
                                                        topRight:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8)),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color:
                                                          DesignCourseAppTheme
                                                              .grey
                                                              .withOpacity(0.2),
                                                      offset: const Offset(
                                                          1.1, 1.1),
                                                      blurRadius: 8.0),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Hero(
                                                    tag: Random()
                                                        .nextInt(1000)
                                                        .toString(),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                16.0),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/lix1.png",
                                                        width: double.infinity,
                                                        height: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 4.0,
                                                        left: 4,
                                                        right: 8),
                                                    child: Text(
                                                      "Bột giặt thương hiệu Lixco",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(child: Container()),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: Text(
                                                            'đ12.345',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              letterSpacing:
                                                                  0.27,
                                                              color: Vx.red600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      10.heightBox,
                      //Thông tin chi tiết
                      Container(
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
                              SizedBox(
                                child: "Thông tin chi tiết".text.bold.make(),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Divider(
                                color:
                                    DesignCourseAppTheme.grey.withOpacity(0.6),
                                height: 1,
                              ),
                              for (var i = 0; i < 4; i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          'Tồn kho ${i + 1}',
                                          style: const TextStyle(
                                            color:
                                                DesignCourseAppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
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
                      ),
                      //Đoạn này dành cho comment
                      10.heightBox,
                      Container(
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
                      ),
                      //Đoạn này dành cho các sản phẩm cùng loại(Bột giặt, nước giặt,...)
                      10.heightBox,
                      Container(
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
                                  Map restaurant = restaurants[index];
                                  return ProductCardItem(
                                    img: restaurant['img'],
                                    title: restaurant['title'],
                                    address: restaurant['address'],
                                    rating: restaurant['rating'],
                                  );
                                },
                                itemCount: restaurants.length,
                              ),
                            ],
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
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Random().nextInt(1000).toString(),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: SizedBox(
          // color: appColor,
          child: Image.asset(
            'assets/images/lix3.png',
            width: MediaQuery.of(context).size.width,
            errorBuilder: (context, error, stackTrace) {
              print('$error');
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
      ),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    toolbarHeight: 40.0,
    backgroundColor: DesignCourseAppTheme.nearlyWhite,
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
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
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
            height: 40,
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
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test "
        "Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test Đây là văn bản test";
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
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Quay lại trang chủ', icon: Icons.home);
  static const share = MenuItem(text: 'Chia sẻ sản phẩm', icon: Icons.share);
  static const settings = MenuItem(text: 'Báo cáo sản phẩm', icon: Icons.bug_report_sharp);
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
      case MenuItems.settings:
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


//Voucher
class _Voucher_Popup extends StatelessWidget {
  const _Voucher_Popup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "null",
      child: Material(
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

