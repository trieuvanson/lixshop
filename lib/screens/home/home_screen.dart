
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../screen.dart';
import 'home_banner_screen.dart';
import 'home_products_type_screen.dart';
import 'products_show_card_row_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Vx.red700,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: _SliverHeaderBar(
                expandedHeight: _offset >= 580 ? 300 : 120,
                minHeight: _offset >= 580 ? 150 : 96),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const HomeBannerScreen(),
                10.heightBox,
                buildProductTitleRow("", context),
                const HomeProductsTypeScreen(),
                10.heightBox,
                buildProductTitleRow("Khuyến mãi", context),
                const ProductShowCardRowItem(isSales: true),
                10.heightBox,
                buildProductTitleRow("Sản phẩm bán chạy", context),
                const ProductShowCardRowItem(isHot: true,),
                10.heightBox,
                buildProductTitleRow("Sản phẩm mới", context),
                const ProductShowCardRowItem(isNew: true,),
                10.heightBox,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductTitleRow(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          FlatButton(
            child: Text(
              "Xem thêm",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const ProductsScreen();
                  },
                  settings: const RouteSettings(name: '/products'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildLocation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Vx.green700,
              ),
              5.widthBox,
              "Giao tới: Số 3, đường số 2, khu phố 4,..."
                  .text
                  .bold
                  .size(16)
                  .green700
                  .make(),
            ],
          ),
          // 64.widthBox,
          const Icon(
            Icons.arrow_drop_down,
            color: Vx.green700,
          ),
        ],
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        elevation: 6.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.to(
                  () => SearchScreen(),
                  routeName: '/search',
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 300),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    "Search for Bột giặt, Nước giặt..."
                        .text
                        .gray500
                        .size(16)
                        .make(),
                  ],
                ),
              ),
              // 64.widthBox,
              IconButton(
                onPressed: () {
                  print('Search for camera');
                },
                icon: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverHeaderBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;

  _SliverHeaderBar({required this.expandedHeight, required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: _SearchCard(),
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: (1 - shrinkOffset / expandedHeight),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      // alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Vx.green700,
                              ),
                              5.widthBox,
                              "Giao tới: Số 3, đường số 2, khu phố 4,..."
                                  .text
                                  .bold
                                  .size(16)
                                  .green700
                                  .make(),
                            ],
                          ),
                          // 64.widthBox,
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Vx.green700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                minHeight >= 150
                    ?FutureBuilder<ProductsDataModel>(
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
                )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;


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
    return const SizedBox(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Text(
            "Có lỗi xảy ra",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesWidget(ProductsDataModel productsDataModel/*TrailersModel data*/) {
    ProductCateModel productCateModel = ProductCategoryRepository().getAllCategories2(productsDataModel);
    // List<Video>? videos = data.trailers;
    return SizedBox(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                productCateModel.productCates!.length,
                    (index) => Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                        color: Colors.green,
                        animationDuration: const Duration(
                            milliseconds: 500),
                        onPressed: () {
                          Get.to(
                                () => const ProductsScreen(),
                          );
                        },
                        child: Text(
                          productCateModel.productCates![index].cateName??"",
                          style: const TextStyle(
                              color: Colors.white),
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ),
        ),
    );
  }



}
