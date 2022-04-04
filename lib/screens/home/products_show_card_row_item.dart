import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/home/products_type_screen.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/widgets.dart';

class ProductShowCardRowItem extends StatefulWidget {
  final bool? isSales;
  final bool? isHot;
  final bool? isNew;
  final String? title;

  const ProductShowCardRowItem({
    Key? key,
    this.isSales = false,
    this.isHot = false,
    this.isNew = false,
    this.title,
  }) : super(key: key);

  @override
  _ProductShowCardRowItemState createState() => _ProductShowCardRowItemState();
}

class _ProductShowCardRowItemState extends State<ProductShowCardRowItem> {
  List<ProductBrand> products = [];

  @override
  Widget build(BuildContext context) {
    print(widget.title);
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
                      Get.to(() => ProductsTypeScreen(products: products,));
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

    if (widget.isSales!) {
      products = productBrandModel.productBrands!.where((product) {
        return product.saleProd!;
      }).toList();
    } else if (widget.isHot!) {
      products = productBrandModel.productBrands!.where((product) {
        return product.hotProd!;
      }).toList();
    } else if (widget.isNew!) {
      products = productBrandModel.productBrands!.where((product) {
        return product.newProd!;
      }).toList();
    }

    return Builder(
      builder: (BuildContext context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            10,
            (index) {
              ProductBrand product = products[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                child: ProductCardItem(
                  img: product.brand!,
                  title: product.brandName!,
                  idBrand: product.brandId!.toInt(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
