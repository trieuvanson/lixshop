import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/screens/home/home_banner_screen.dart';
import 'package:lixshop/screens/home/home_products_type_screen.dart';
import 'package:lixshop/screens/home/products_show_card_row_item.dart';
import 'package:lixshop/screens/product/products_screen.dart';
import 'package:lixshop/screens/search/search_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../cart/cart_screen.dart';

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
        print('offset: $_offset');
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
                minHeight: _offset >= 580 ? 200 : 96),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const HomeBannerScreen(),
                10.heightBox,
                buildRestaurantRow("", context),
                const HomeProductsTypeScreen(),
                10.heightBox,
                buildRestaurantRow("Khuyến mãi", context),
                const ProductShowCardRowItem(),
                10.heightBox,
                buildRestaurantRow("Sản phẩm bán chạy", context),
                const ProductShowCardRowItem(),
                10.heightBox,
                buildRestaurantRow("Sản phẩm mới", context),
                const ProductShowCardRowItem(),
                10.heightBox,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRestaurantRow(String title, BuildContext context) {
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
              "Xem thêm (9)",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            onPressed: () {
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
          child: InkWell(
            // onTap: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const LoginScreen(),
            //   ),
            // ),
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 150,
              height: 50,
              alignment: Alignment.center,
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
      child: InkWell(
        onTap: () {},
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
                  minHeight >= 200
                      ? const Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: _SearchCard(),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _test(BuildContext context, double shrinkOffset) {
    return Container(
      height: expandedHeight,
      child: Stack(
        children: [
          Positioned(
            top: expandedHeight / 2 - shrinkOffset,
            left: MediaQuery.of(context).size.width / 4,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Card(
                elevation: 10,
                child: SizedBox(
                  height: expandedHeight,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const FlutterLogo(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
