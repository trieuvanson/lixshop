import 'package:flutter/material.dart';
import 'package:lixshop/screens/home1/widgets/product_type_item_row.dart';
import '../constants.dart';
import 'app_bar_header.dart';
import 'product_card.dart';
import 'sliver_categories_bar.dart';
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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const AppBarHeaderSliver(),
        SliverPadding(
          padding: EdgeInsets.zero,
          sliver: SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.4,
                    margin: EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2.5 - padding.top,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/cm1.jpeg",
                          width: size.width * 0.4,
                          height: size.height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: size.width * 0.4,
                            height: 45,
                            child: RichText(
                              text: TextSpan(
                                  text: "Đây là sản phẩm từ 1 số nơi nào đó"
                                      .toUpperCase(),
                                  style: Theme.of(context).textTheme.button),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    margin: const EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2.5,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/cm1.jpeg",
                          width: size.width * 0.4,
                          height: size.height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: size.width * 0.4,
                            height: 45,
                            child: RichText(
                              text: TextSpan(
                                  text: "Đây là sản phẩm từ 1 số nơi nào đó"
                                      .toUpperCase(),
                                  style: Theme.of(context).textTheme.button),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    margin: const EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2.5,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/cm1.jpeg",
                          width: size.width * 0.4,
                          height: size.height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: size.width * 0.4,
                            height: 45,
                            child: RichText(
                              text: TextSpan(
                                  text: "Đây là sản phẩm từ 1 số nơi nào đó"
                                      .toUpperCase(),
                                  style: Theme.of(context).textTheme.button),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    margin: const EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2.5,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/cm1.jpeg",
                          width: size.width * 0.4,
                          height: size.height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: size.width * 0.4,
                            height: 45,
                            child: RichText(
                              text: TextSpan(
                                  text: "Đây là sản phẩm từ 1 số nơi nào đó"
                                      .toUpperCase(),
                                  style: Theme.of(context).textTheme.button),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverCategoriesBar(),
        const SliverPadding(
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
        const SliverPadding(
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
        const SliverPadding(
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
