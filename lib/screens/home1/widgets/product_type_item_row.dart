import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../core/core.dart';
import '../../../models/models.dart';
import '../products_type_screen.dart';
import 'product_card.dart';
import 'product_items_loader.dart';
import 'widgets.dart';

class ProductTypeItemRow extends StatefulWidget {
  final ProductCardType type;
  final String title;

  const ProductTypeItemRow({Key? key, required this.type, required this.title})
      : super(key: key);

  @override
  State<ProductTypeItemRow> createState() => _ProductTypeItemRowState();
}

class _ProductTypeItemRowState extends State<ProductTypeItemRow> {
  var products;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
      builder: (context, state) {
        return Column(
          children: [
            TitleWithMoreButton(
                title: widget.title,
                onPressed: state.isLoading
                    ? () {}
                    : () =>
                        {Get.to(() => ProductsTypeScreen(products: products))}),
            Builder(builder: (_) {
              if (state.isLoading) {
                return const ProductItemsLoader(
                    type: ProductLoaderType.loading);
              } else if (state.isError) {
              } else if (state.isSuccess) {
                List<ProductOutsideBrand> subProducts =
                    productOutsideBrandController
                        .getProductOutsideBrandList(state.resultDataModel!);
                products = productOutsideBrandController.filterProductsBrand(
                    list: subProducts, type: widget.type);
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final product in products.take(10))
                        ProductCard(
                          product: product,
                        ),
                    ],
                  ),
                );
              }
              return Container();
            })
          ],
        );
      },
    );
  }
}
