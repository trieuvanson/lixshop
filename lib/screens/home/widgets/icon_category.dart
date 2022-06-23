import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/products_outside_data/product_outside_category_model.dart';
import 'package:lixshop/screens/home/categories_products_screen.dart';
import 'package:lixshop/utils/design_course_app_theme.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';

class IconCategory extends StatefulWidget {
  final ProductOutsideCategory item;

  const IconCategory({Key? key, required this.item}) : super(key: key);

  @override
  State<IconCategory> createState() => _IconCategoryState();
}

class _IconCategoryState extends State<IconCategory> {
  var products;
  @override
  Widget build(BuildContext context) {
    var products = widget.item.productBrand;
    return InkWell(
      onTap: () {
        Get.to(() => CategoryProductScreen(
              category: widget.item,
              products: products!,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: 309 / 3.0,
          height: 510 / 2.5,
          child: Column(
            children: [
              Container(
                width: 309 / 4.0,
                height: 510 / 4.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2.0,
                        spreadRadius: 0.5)
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.item.catePath ?? 'assets/images/cm1.jpeg'),
                    onError: (context, error) {},
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                widget.item.cateName ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.button,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
