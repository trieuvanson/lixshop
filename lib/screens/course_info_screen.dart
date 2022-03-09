import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/design_course_app_theme.dart';
import '../utils/hero_dialog_route.dart';
import '../widgets/popup/product_voucer_popup.dart';
import '../widgets/text_form_field.dart';

class CourseInfoScreen extends StatefulWidget {
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
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
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: _BottomNavigation(opacity3: opacity3),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _ProductImage(),
              5.heightBox,
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
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: infoHeight,
                      maxHeight:
                      tempHeight > infoHeight ? tempHeight : infoHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                                    const TodoPopupCard(),
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
                      InkWell(
                        onTap: () {
                          print('Ahiih');
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Vx.gray700.withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .grey
                                                      .withOpacity(0.2),
                                                  offset:
                                                  const Offset(1.1, 1.1),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/lix1.png",
                                              width: 50,
                                              fit: BoxFit.cover,
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
                      ),
                      10.heightBox,
                      Container(
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
                          child: Container()),
                      // AnimatedOpacity(
                      //   duration: const Duration(milliseconds: 500),
                      //   opacity: opacity1,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8),
                      //     child: Row(
                      //       children: <Widget>[
                      //         getTimeBoxUI('24', 'Classe'),
                      //         getTimeBoxUI('2hours', 'Time'),
                      //         getTimeBoxUI('24', 'Seat'),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Card(
                      //     color: Colors.yellow,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         const Text(
                      //           "Header",
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: const [
                      //               Text("Thông số 1"),
                      //               Text("Thông số 2"),
                      //               Text("Thông số 3"),
                      //               Text("Thông số 4"),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: Column(
                                children: const [
                                  Text(
                                    'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
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

PreferredSizeWidget appBar(BuildContext context) {
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
          Icons.share,
          color: DesignCourseAppTheme.dark_grey,
        ),
        onPressed: () {},
      ),
      //menu
      PopupMenuButton<String>(
        onSelected: (String value) {},
        icon: const Icon(
          Icons.more_vert,
          color: DesignCourseAppTheme.dark_grey,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem<String>(
            value: 'Delete',
            child: Text('Delete'),
          ),
        ],
      ),
    ],
  );
}

class _BottomNavigation extends StatelessWidget {
  final double opacity3;

  const _BottomNavigation({Key? key, required this.opacity3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity3,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Container(
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
                            //  Chỉ số dương
                          ],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: DesignCourseAppTheme.grey,
                            ),
                          ),
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
            const SizedBox(
              width: 16,
            ),
            Expanded(
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
        ),
      ),
    );
  }
}
