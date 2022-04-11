import 'package:flutter/material.dart';
import '../constants.dart';

import '../controller/controllers.dart';
import 'app_bar_header.dart';
import 'product_card.dart';
import 'sliver_categories_bar.dart';
import 'widgets.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder(
      valueListenable: sliverScrollController.globalOffSetValue,
      builder: (_, double valueCurrentScroll, ___) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: sliverScrollController.scrollControllerGlobally,
          slivers: [
            AppBarHeaderSliver(
              valueCurrentScroll: valueCurrentScroll,
            ),

            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 2),
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
                                      style:
                                          Theme.of(context).textTheme.button),
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
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 2),
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
                                      style:
                                          Theme.of(context).textTheme.button),
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
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 2),
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
                                      style:
                                          Theme.of(context).textTheme.button),
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
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 2),
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
                                      style:
                                          Theme.of(context).textTheme.button),
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

/*            SliverPadding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding + 36,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Best Selling',
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Container(
                      height: size.height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            color: kPrimaryColor,
                            width: size.width * 0.4,
                            margin: const EdgeInsets.only(
                                right: kDefaultPadding / 2),
                            height: size.height * 0.2,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            const SliverCategoriesBar(),
            // container
            _sliverPaddingTitleWithMoreButton(
              title: "Sản phẩm mới",
              onPressed: () {},
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
              ),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) ...[
                        const ProductCard()
                      ]
                    ],
                  ),
                ),
              ),
            ),

            _sliverPaddingTitleWithMoreButton(
              title: "Sản phẩm bán chạy",
              onPressed: () {},
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) ...[
                        const ProductCard()
                      ]
                    ],
                  ),
                ),
              ),
            ),

            _sliverPaddingTitleWithMoreButton(
              title: "Sản phẩm nổi bật",
              onPressed: () {},
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) ...[
                        const ProductCard()
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
