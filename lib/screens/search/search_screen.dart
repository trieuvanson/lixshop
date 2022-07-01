import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/constants/contains.dart';
import 'package:lixshop/core/core.dart';
import 'package:lixshop/screens/product/product_details_screen.dart';
import 'package:lixshop/screens/search/data/popular_keyword.dart';
import 'package:lixshop/screens/search/search_results.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/search_controller.dart';
import '../../utils/design_course_app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController keywordController;
  String keyword = "";

  @override
  initState() {
    keywordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    keywordController.clear();
    keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(),
        body: keyword.isNotEmpty
            ? keyWordSearchNotEmpty()
            : keyWordSearchIsEmpty(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0,
      leadingWidth: 30,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      title: Container(
          width: double.infinity,
          // height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: keywordController,
            autofocus: true,
            onFieldSubmitted: (value) {
              keyword = value;
              setState(() {});
              if (value.trim().isNotEmpty) {
                Get.to(
                  () => SearchResults(keyword: value),
                  routeName: '/products?keyword=$value',
                  duration: const Duration(milliseconds: 300),
                );
              }
            },
            onChanged: (value) {
              keyword = value;
              setState(() {});
            },
            selectionControls: materialTextSelectionControls,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                suffixIcon: keyword.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            keywordController.clear();
                            keyword = "";
                          });
                        },
                      )
                    : null,
                border: InputBorder.none),
          )),
    );
  }

  Widget keyWordSearchNotEmpty() {
    return BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
      builder: (context, state) {
        if (state.isSuccess) {
          var products = searchController.search(
              keyword: keyword,
              categories: state.resultDataModel!.productOutsideCategory!);
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: DesignCourseAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < products.length; i++)
                          _MenuItem(
                              image: products[i].brand!,
                              title: "${products[i].brandName}",
                              onTap: () {
                                Get.to(() => ProductDetailsScreen(
                                    idBrand: products[i].brandId!.toInt()));
                                // Get.to(
                                //   () =>
                                //       ProductsScreen(keyword: "${widget.keyword} $i"),
                                //   routeName: '/products?keyword=${widget.keyword} $i',
                                //   transition: Transition.downToUp,
                                //   duration: const Duration(milliseconds: 300),
                                // );
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget keyWordSearchIsEmpty() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchRowTitle(title: "Lịch sử"),
              SearchItem(icon: Icons.history, keywords: popularKeyword),
              const SearchRowTitle(title: "Tìm kiếm phổ biến"),
              SearchItem(icon: Icons.search, keywords: popularKeyword)
            ],
          ),
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final IconData icon;
  final List keywords;

  const SearchItem({Key? key, required this.icon, required this.keywords})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.symmetric(vertical: 10),
      childAspectRatio: 3,
      children: [
        for (var search in keywords)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: DesignCourseAppTheme.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => SearchResults(keyword: search!),
                    routeName: '/products?keyword=$search',
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                        width: size.width * 0.3 - 36,
                        child: " $search"
                            .text
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(1)
                            .make()),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class SearchRowTitle extends StatelessWidget {
  final String title;

  const SearchRowTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        child: title.text.xl2.bold.make(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String image;
  final String title;
  final Widget? subTitle;
  final GestureTapCallback? onTap;

  const _MenuItem(
      {Key? key,
      required this.title,
      this.subTitle,
      this.onTap,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(image), scale: 309 / 510),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 8.0),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * 0.7,
                child: title.text
                    .size(16)
                    .gray700
                    .overflow(TextOverflow.ellipsis)
                    .make(),
              ),
              Row(
                children: [
                  subTitle ?? const SizedBox.shrink(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Vx.gray500,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
