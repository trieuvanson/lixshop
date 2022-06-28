import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../core/core.dart';
import '../../models/models.dart';
import '../home/widgets/product_card.dart';
import '../screen.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset;
      });
    });
    super.initState();
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
                // buildProductTitleRow("", context),
                const HomeProductsType(),
                10.heightBox,
                const ProductShowCardRowItem(
                    type: ProductCardType.isSale, title: "Sản phẩm khuyến mãi"),
                10.heightBox,
                const ProductShowCardRowItem(
                    type: ProductCardType.isHot, title: "Sản phẩm nổi bật"),
                10.heightBox,
                const ProductShowCardRowItem(
                    type: ProductCardType.isNew, title: "Sản phẩm mới"),
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
            onPressed: () {},
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
                  () => const SearchScreen(),
                  routeName: '/search',
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
                onPressed: () {},
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is SuccessAuthState) {
                      return Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: (1 - shrinkOffset / expandedHeight),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: "Giao tới: ${state.user.address}"
                                          .text
                                          .maxLines(1)
                                          .overflow(TextOverflow.ellipsis)
                                          .bold
                                          .size(16)
                                          .green700
                                          .make(),
                                    ),
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
                      );
                    }
                    return Container();
                  },
                ),
                minHeight == 150
                    ? BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return _buildLoadingWidget();
                          } else if (state.isError) {
                            return Container();
                          } else if (state.resultDataModel!
                              .productOutsideCategory!.isNotEmpty) {
                            return _buildCategoriesWidget(
                                state.resultDataModel!);
                          }
                          return Container();
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

  Widget _buildCategoriesWidget(
      ResultDataModel resultDataModel /*TrailersModel data*/) {
    List<ProductOutsideCategory> categories =
        resultDataModel.productOutsideCategory!;
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
                categories.length,
                (index) => Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green,
                    animationDuration: const Duration(milliseconds: 500),
                    onPressed: () {
                      // Get.to(() => ProductsScreen(category: categories[index]));
                    },
                    child: Text(
                      categories[index].cateName ?? "",
                      style: const TextStyle(color: Colors.white),
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
