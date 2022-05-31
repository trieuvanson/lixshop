import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/products_outside_data/product_outside_category_model.dart';
import 'package:lixshop/screens/home/categories_products_screen.dart';

import '../../../controllers/controllers.dart';
import '../../../core/core.dart';
import '../../../models/models.dart';
import 'product_items_loader.dart';

class IconCategory extends StatefulWidget {
  final ProductOutsideCategory item;

  const IconCategory({Key? key, required this.item}) : super(key: key);

  @override
  State<IconCategory> createState() => _IconCategoryState();
}

class _IconCategoryState extends State<IconCategory> {
  var products;
  final productOutsideBrandController = ProductOutsideBrandController();

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
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 100.0,
          height: 130,
          child: Column(
            children: [
              Container(
                height: 80.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.5)
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
