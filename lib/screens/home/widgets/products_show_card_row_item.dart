import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/core/core.dart';
import 'package:lixshop/screens/home/products_type_screen.dart';
import 'package:lixshop/screens/home1/widgets/product_card.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../utils/design_course_app_theme.dart';
import '../../../widgets/widgets.dart';

class ProductShowCardRowItem extends StatefulWidget {
  final ProductCardType type;
  final String? title;

  const ProductShowCardRowItem({
    Key? key,
    this.title,
    required this.type,
  }) : super(key: key);

  @override
  _ProductShowCardRowItemState createState() => _ProductShowCardRowItemState();
}

class _ProductShowCardRowItemState extends State<ProductShowCardRowItem> {
  List<ProductOutsideBrand> products = [];
  final productOutsideBrandController = ProductOutsideBrandController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title ?? '',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProductsTypeScreen(
                            products: products,
                          ));
                    },
                    child: const Text(
                      'Xem thêm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.27,
                        color: DesignCourseAppTheme.nearlyBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
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
              child: buildProductList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductList() {
    return BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container();
        } else if (state.isError) {
          return Container();
        } else if (state.isSuccess) {
          return _buildProductsWidget(state.resultDataModel!);
        }
        return Container();
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductsWidget(ResultDataModel resultDataModel) {
    List<ProductOutsideBrand> productsOutside = productOutsideBrandController
        .getProductOutsideBrandList(resultDataModel);
    products = productOutsideBrandController.filterProductsBrand(
        list: productsOutside, type: widget.type);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        products.length,
        (index) {
          ProductOutsideBrand product = products[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8),
            child: ProductCardItem(
              product: product,
            ),
          );
        },
      ),
    );
  }
}
