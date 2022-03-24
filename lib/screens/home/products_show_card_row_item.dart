import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/repositories/repositories.dart';

import '../../models/productlist.dart';
import '../../repositories/product/product_repositories.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/product_card_item.dart';
import '../product/product_detail_screen.dart';

class ProductShowCardRowItem extends StatefulWidget {
  final bool? isSales;
  final bool? isHot;
  final bool? isNew;

  const ProductShowCardRowItem({
    Key? key,
    this.isSales = false,
    this.isHot = false,
    this.isNew = false,
  }) : super(key: key);

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
          child: buildProductList(),
        ),
      ),
    );
  }

  Widget buildProductList() {
    return FutureBuilder<ProductsDataModel>(
      future: ProductsDataRepositories().getProductsData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildProductsWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
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

  //display error
  Widget _buildErrorWidget(dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Something is wrong',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductsWidget(ProductsDataModel productsDataModel) {
    ProductBrandModel productBrandModel =
        ProductRepositories().getProducts(productsDataModel);
    List<ProductBrand> products = [];

    if (widget.isSales!) {
      products = productBrandModel.productBrands!
          .where((product) {
            return product.saleProd!;
          })
          .take(10)
          .toList();
    } else if (widget.isHot!) {
      products = productBrandModel.productBrands!
          .where((product) {
            return product.hotProd!;
          })
          .take(10)
          .toList();
    } else if (widget.isNew!) {
      products = productBrandModel.productBrands!
          .where((product) {
            return product.newProd!;
          })
          .take(10)
          .toList();
    }

    return Builder(
      builder: (BuildContext context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            products.length,
            (index) {
              ProductBrand product = products[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                child: ProductCardItem(
                  img: product.brand!,
                  title: product.brandName!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
