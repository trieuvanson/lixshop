import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../core/core.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
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
 late List<ProductOutsideBrand> products;
  final productOutsideBrandController = ProductOutsideBrandController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: resultDataOutsideRepository.getResultData(),
      builder: (context, AsyncSnapshot<ResultDataModel> snapshot) {
        ResultDataModel? resultDataModel = snapshot.data;
        return snapshot.hasData
            ? resultDataModel!.productOutsideCategory!.isNotEmpty
                ? Column(
                    children: [
                      TitleWithMoreButton(
                          title: widget.title,
                          onPressed: () => {
                                Get.to(() => ProductsTypeScreen(
                                      products: products,
                                      title: widget.title,
                                    ))
                              }),
                      Builder(builder: (_) {
                        List<ProductOutsideBrand> subProducts =
                            productOutsideBrandController
                                .getProductOutsideBrandList(resultDataModel);
                        products =
                            productOutsideBrandController.filterProductsBrand(
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
                      })
                    ],
                  )
                : Container()
            : const ProductItemsLoader(
                type: ProductLoaderType.loading,
              );
      },
    );

    return BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Column(
          children: [
            TitleWithMoreButton(
                title: widget.title,
                onPressed: (state.isLoading || state.isError)
                    ? () {}
                    : () => {
                          Get.to(() => ProductsTypeScreen(
                                products: products,
                                title: widget.title,
                              ))
                        }),
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
