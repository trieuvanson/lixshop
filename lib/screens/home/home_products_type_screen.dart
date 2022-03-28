import 'package:flutter/material.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/repositories/category/product_category_repository.dart';
import 'package:lixshop/repositories/products_data/products_data_repositories.dart';

import '../../utils/design_course_app_theme.dart';
import '../product/products_screen.dart';

class HomeProductsTypeScreen extends StatefulWidget {
  const HomeProductsTypeScreen({Key? key}) : super(key: key);

  @override
  _HomeProductsTypeScreenState createState() => _HomeProductsTypeScreenState();
}

class _HomeProductsTypeScreenState extends State<HomeProductsTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductsDataModel>(
      future: ProductsDataRepositories().getProductsData(),
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildCategoriesWidget(snapshot.data!);
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  //display error
  Widget _buildErrorWidget(dynamic error) {
    return const Center(
      child: Text(
        'Có lỗi xảy ra',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildCategoriesWidget(ProductsDataModel productsDataModel/*TrailersModel data*/) {
    // List<Video>? videos = data.trailers;
    ProductCateModel productCateModel = ProductCategoryRepository().getAllCategories2(productsDataModel);
      return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DesignCourseAppTheme.nearlyWhite,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: DesignCourseAppTheme.notWhite,
              offset: Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, top: 4.0, bottom: 4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              productCateModel.productCates!.length,
                  (index) => ProductTypeCard(
                imagePath: productCateModel.productCates![index].catePath??"",
                title: productCateModel.productCates![index].cateName??"",
              ),
            ),
          ),
        ),
      ),
    );
  }










}

class ProductTypeCard extends StatefulWidget {
  final String imagePath;
  final String title;

  const ProductTypeCard(
      {Key? key, required this.imagePath, required this.title})
      : super(key: key);

  @override
  _ProductTypeCardState createState() => _ProductTypeCardState();
}

class _ProductTypeCardState extends State<ProductTypeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductsScreen(),
            settings: const RouteSettings(
              name: '/products',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 130,
          decoration: BoxDecoration(
            color: DesignCourseAppTheme.nearlyWhite,
            borderRadius: BorderRadius.circular(10),
            border:
            Border.all(color: DesignCourseAppTheme.grey.withOpacity(0.2)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 8.0),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      widget.imagePath,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4, right: 8),
                child: Center(
                  child: Text(
                    (widget.title[0] +  widget.title.substring(1).toLowerCase()),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
