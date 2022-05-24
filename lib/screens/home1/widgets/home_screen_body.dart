import 'package:flutter/material.dart';
import 'package:lixshop/screens/home1/widgets/product_type_item_row.dart';
import '../constants.dart';
import 'app_bar_header.dart';
import 'product_card.dart';
import 'sliver_categories_bar.dart';
import 'sliver_header_banner.dart';
import 'widgets.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        AppBarHeaderSliver(),
        SliverHeaderBanner(),
        SliverCategoriesBar(),
        SliverPadding(
          padding: EdgeInsets.only(
            left: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
          ),
          sliver: SliverToBoxAdapter(
            child: ProductTypeItemRow(
              title: "Sản phẩm mới",
              type: ProductCardType.isNew,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
          ),
          sliver: SliverToBoxAdapter(
            child: ProductTypeItemRow(
              title: "Sản phẩm bán chạy",
              type: ProductCardType.isHot,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
          ),
          sliver: SliverToBoxAdapter(
            child: ProductTypeItemRow(
              title: "Sản phẩm khuyến mãi",
              type: ProductCardType.isSale,
            ),
          ),
        ),
      ],
    );
  }

  SliverPadding _sliverPaddingTitleWithMoreButton(
      {required String title, required VoidCallback onPressed}) {
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverToBoxAdapter(
        child: TitleWithMoreButton(title: title, onPressed: onPressed),
      ),
    );
  }
}
