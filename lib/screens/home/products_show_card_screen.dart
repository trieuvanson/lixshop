import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/restaurants.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/product_card_item.dart';
import '../product/product_detail_screen.dart';

class ProductShowCard extends StatefulWidget {
  const ProductShowCard({Key? key}) : super(key: key);

  @override
  _ProductShowCardState createState() => _ProductShowCardState();
}

class _ProductShowCardState extends State<ProductShowCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DesignCourseAppTheme.nearlyWhite,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: DesignCourseAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, top: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              restaurants.length,
                  (index) {
                Map restaurant = restaurants[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: ProductCardItem(
                    img: restaurant['img'],
                    title: restaurant['title'],
                    address: restaurant['address'],
                    rating: restaurant['rating'],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
