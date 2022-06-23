import 'package:flutter/material.dart';
import 'package:lixshop/screens/home/widgets/product_items_loader.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import '../constants/constants.dart';
import 'app_bar_header.dart';
import 'category_items_loader.dart';
import 'icon_category.dart';
import 'product_card.dart';
import 'product_type_item_row.dart';
import 'sliver_categories_bar.dart';
import 'sliver_header_banner.dart';
import 'widgets.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  List<ProductOutsideCategory>? _subProducts;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    getResultData();
    super.initState();
  }

  getResultData() async {
    try {
      ResultDataModel? _resultDataModel =
          await resultDataOutsideRepository.getResultData();
      setState(() {
        if (_resultDataModel.productOutsideCategory == null) {
          _isError = true;
          return;
        }
        _subProducts = _resultDataModel.productOutsideCategory;
        _isError = false;
      });
    } catch (e) {
      _isError = true;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const AppBarHeaderSliver(),
        const SliverHeaderBanner(),
        buildCategoryRow(),
        buildProductTypeRow(title: "Sản phẩm mới", type: ProductCardType.isNew),
        buildProductTypeRow(
            title: "Sản phẩm bán chạy", type: ProductCardType.isHot),
        buildProductTypeRow(
            title: "Sản phẩm khuyến mãi", type: ProductCardType.isSale),
      ],
    );
  }

  Widget buildProductTypeRow(
      {required String title, required ProductCardType type}) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding / 2,
        right: kDefaultPadding / 2,
      ),
      sliver: SliverToBoxAdapter(
        child: _isLoading
            ? const ProductItemsLoader(type: ProductLoaderType.loading)
            : _isError
                ? Container()
                : ProductTypeItemRow(
                    productOutsideCategory: _subProducts!,
                    title: title,
                    type: type,
                  ),
      ),
    );
  }

  Widget buildCategoryRow() {
    final padding = MediaQuery.of(context).padding;
    return SliverPadding(
      sliver: SliverPersistentHeader(
        delegate: HeaderSliver(
          isLoading: _isLoading,
          isError: _isError,
          productOutsideCategory: _subProducts ?? [],
        ),
        pinned: true,
      ),
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding,
      ),
    );
  }
}

class HeaderSliver extends SliverPersistentHeaderDelegate {
  final bool isLoading;
  final bool isError;
  final List<ProductOutsideCategory> productOutsideCategory;

  HeaderSliver(
      {required this.isLoading,
      required this.isError,
      required this.productOutsideCategory});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool visible = shrinkOffset > 0;
    final padding = MediaQuery.of(context).padding;
    return isLoading
        ? const CategoryItemsLoader(
            type: CategoryLoaderType.loading,
          )
        : isError
            ? const CategoryItemsLoader(
                type: CategoryLoaderType.error,
              )
            : Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: padding.top),
                    color: kBackgroundColor,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var item in productOutsideCategory) ...[
                            IconCategory(item: item),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              );
    // return FutureBuilder(
    //   future: resultDataOutsideRepository.getResultData(),
    //   builder: (context, AsyncSnapshot<ResultDataModel> snapshot) {
    //     ResultDataModel? resultDataModel = snapshot.data;
    //     return snapshot.hasData
    //         ? resultDataModel!.productOutsideCategory!.isNotEmpty
    //         ? Stack(
    //       children: [
    //         Container(
    //           padding: EdgeInsets.only(top: padding.top),
    //           color: kBackgroundColor,
    //           child: SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: Row(
    //               children: [
    //                 for (var item in resultDataModel
    //                     .productOutsideCategory!) ...[
    //                   IconCategory(item: item),
    //                 ]
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     )
    //         : const CategoryItemsLoader(
    //       type: CategoryLoaderType.error,
    //     )
    //         : const CategoryItemsLoader(
    //       type: CategoryLoaderType.loading,
    //     );
    //   },
    // );
    // return BlocConsumer<ResultOutsideCubit, ResultOutsideState>(
    //   listener: (context, state) {
    //     if (state.isError) {
    //       showSnackBar("Lỗi hệ thống, vui lòng thử lại sau!", context,
    //           duration: 3000);
    //     }
    //   },
    //   listenWhen: (previous, current) => previous != current,
    //   buildWhen: (previous, current) => previous != current,
    //   builder: (context, state) {
    //     if (state.isLoading) {
    //       return const CategoryItemsLoader(
    //         type: CategoryLoaderType.loading,
    //       );
    //     } else if (state.isError) {
    //       return const CategoryItemsLoader(
    //         type: CategoryLoaderType.error,
    //       );
    //     } else if (state.isSuccess) {
    //       return Stack(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(top: padding.top),
    //             color: kBackgroundColor,
    //             width: double.infinity,
    //             child: SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //               child: Row(
    //                 children: [
    //                   for (var item in state
    //                       .resultDataModel!.productOutsideCategory!) ...[
    //                     IconCategory(item: item),
    //                   ]
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //
    //     return Container();
    //   },
    // );
  }

  @override
  double get minExtent => 224;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => 224;
}
