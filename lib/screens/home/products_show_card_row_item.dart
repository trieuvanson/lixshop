import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/productlist.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/product_card_item.dart';
import '../product/product_detail_screen.dart';

class ProductShowCardRowItem extends StatefulWidget {
  const ProductShowCardRowItem({Key? key}) : super(key: key);

  @override
  _ProductShowCardRowItemState createState() => _ProductShowCardRowItemState();
}

class _ProductShowCardRowItemState extends State<ProductShowCardRowItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DesignCourseAppTheme.notWhite,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: DesignCourseAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
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
                    id: restaurant['id'],
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
