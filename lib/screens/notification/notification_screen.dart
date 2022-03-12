import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';
import '../order_history/order_history_list_screen.dart';
import '../product/product_detail_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: "Thông báo".text.black.make(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          color: DesignCourseAppTheme.nearlyWhite,
          child: Column(
            children: [
              for (var i = 0; i < 10; i++)
                _NotificationItem(
                  title: "Chương trình khuyến mãi $i",
                  content: "Thông báo $i",
                  time: "Thứ 2, ngày 12/12/2020",
                  image: "assets/images/lix3.png",
                  onTap: () {
                    Get.to(const ProductDetailScreen());
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String time;
  final String image;
  final GestureTapCallback? onTap;

  const _NotificationItem(
      {Key? key,
      required this.title,
      required this.content,
      required this.time,
      required this.image,
      this.onTap})
      : super(key: key);
  static const content1 =
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi123";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title.text.bold.xl.make(),
                time.text.gray500.make(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReadMoreText(
                content1,
                trimLines: 2,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Line,
                trimCollapsedText: "Xem thêm",
                trimExpandedText: "Ẩn bớt",
                lessStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                moreStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
