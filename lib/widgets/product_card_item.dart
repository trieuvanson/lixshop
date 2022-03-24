import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../screens/product/product_detail_screen.dart';
import '../utils/design_course_app_theme.dart';

class ProductCardItem extends StatefulWidget {
  final String img;
  final String title;
  final String? stickers;

  const ProductCardItem({
    Key? key,
    required this.img,
    required this.title,
    this.stickers,
  }) : super(key: key);

  @override
  _ProductCardItemState createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => const ProductDetailScreen(
              // id: widget.id,
              // img: widget.img,
              // title: widget.title,
              // routeName: '/product-detail1/${widget.id}',
              ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        width: 180,
        height: 230,
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: DesignCourseAppTheme.notWhite,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  widget.img,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.darkerText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
