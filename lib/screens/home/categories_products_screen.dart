import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/models.dart';

import '../../utils/design_course_app_theme.dart';
import '../screen.dart';
import 'constants/constants.dart';
import 'widgets/product_card.dart';

class CategoryProductScreen extends StatefulWidget {
  final category;
  final List<ProductOutsideBrand> products;

  const CategoryProductScreen({Key? key, required this.products, this.category})
      : super(key: key);

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  var _currentProducts;
  final ScrollController _scrollController = ScrollController();
  late int _currentMaxItem;
  bool _isLoading = false;

  @override
  void initState() {
    if (widget.products.length > 10) {
      _currentMaxItem = 10;
    } else {
      _currentMaxItem = widget.products.length;
    }
    _currentProducts = widget.products.sublist(
      0,
      _currentMaxItem,
    );
    if (_currentProducts.length != widget.products.length) {
      loadMore();
    }
    super.initState();
  }

  void loadMore() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _currentProducts.length != widget.products.length) {
        //show SnackBar indicator
        setState(() {
          _isLoading = true;
          int length = widget.products.length - (widget.products.length % 10);
          if (_isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 500),
              content: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
              backgroundColor: Colors.white,
            ));
          }
          if (_currentMaxItem < length) {
            _currentMaxItem += 10;
          } else {
            _currentMaxItem = widget.products.length;
          }
          _currentProducts = widget.products.sublist(
            0,
            _currentMaxItem,
          );
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int index = size.width > 1024 ? 4 : 2;
    return Scaffold(
      backgroundColor: DesignCourseAppTheme.notWhite,
      appBar: appBar(widget.category),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (var product in _currentProducts)
                    ProductCard(
                      product: product,
                    ),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: appBar(widget.category),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        color: DesignCourseAppTheme.notWhite,
        child: GridView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: index,
            mainAxisExtent: size.height * 0.4,
            mainAxisSpacing: kDefaultPadding / 2,
            crossAxisSpacing: kDefaultPadding / 2,
          ),
          itemBuilder: (context, index) {
            var product = _currentProducts[index];
            return InkWell(
              onTap: () {
                Get.to(() => ProductDetailsScreen(
                      idBrand: product.brandId?.toInt() ?? 0,
                    ));
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          product.brand!,
                        ),
                        onError: (context, error) {},
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.08,
                      color: kBackgroundColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              product.brandName!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: _currentProducts.length,
        ),
      ),
    );
  }

  AppBar appBar(final category) {
    return AppBar(
      elevation: 0,
      title: Text(
        category.cateName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      leadingWidth: 30,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.grey[700]),
          onPressed: () {
            Get.to(
              () => const CartScreen(),
              duration: const Duration(milliseconds: 500),
            );
          },
        ),
      ],
    );
  }
}
