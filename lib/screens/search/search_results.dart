import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transitions;
import 'package:lixshop/constants/contains.dart';
import 'package:lixshop/core/core.dart';
import 'package:lixshop/core/cubits/filter/filter_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/search_controller.dart';
import '../../screen_layout.dart';
import '../../utils/design_course_app_theme.dart';
import '../screen.dart';

class SearchResults extends StatefulWidget {
  final String keyword;

  const SearchResults({Key? key, required this.keyword}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final searchController = SearchController();

  @override
  void initState() {
    BlocProvider.of<ResultOutsideCubit>(context).getProductOutside();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterBloc = BlocProvider.of<FilterCubit>(context);
    final size = MediaQuery.of(context).size;
    int index = size.width > 1024 ? 4 : 2;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: _drawer(context, filterBloc),
      ),
      appBar: appBar(),
      body: BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
        builder: (context, state) {
          if (state.isSuccess) {
            return SingleChildScrollView(
              child: Container(
                height: size.height,
                color: DesignCourseAppTheme.notWhite,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      color: DesignCourseAppTheme.notWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 16, top: 16),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  "Kết quả tìm kiếm".text.bold.size(16).make(),
                                  // const Spacer(),
                                  // CustomDropdownButton2(
                                  //   dropdownWidth: 100,
                                  //   buttonWidth: 120,
                                  //   buttonDecoration: BoxDecoration(
                                  //     color: DesignCourseAppTheme.nearlyWhite,
                                  //     borderRadius: const BorderRadius.all(
                                  //       Radius.circular(8.0),
                                  //     ),
                                  //     border: Border.all(
                                  //       color: Vx.gray300,
                                  //     ),
                                  //   ),
                                  //   icon: const Icon(
                                  //     Icons.arrow_drop_down,
                                  //     size: 24,
                                  //   ),
                                  //   hint: 'Đơn vị tính',
                                  //   value: 'Tất cả',
                                  //   onChanged: (String? value) {},
                                  //   dropdownItems: const [
                                  //     "Tất cả",
                                  //     "Tên A-Z",
                                  //     "Tên Z-A",
                                  //   ],
                                  // ),
                                  // 8.widthBox,
                                  // InkWell(
                                  //   onTap: () {
                                  //     scaffoldKey.currentState?.openEndDrawer();
                                  //   },
                                  //   child: Wrap(
                                  //     alignment: WrapAlignment.center,
                                  //     crossAxisAlignment:
                                  //         WrapCrossAlignment.center,
                                  //     children: [
                                  //       const Icon(
                                  //         Icons.filter_list,
                                  //         color: Vx.gray700,
                                  //       ),
                                  //       "Lọc"
                                  //           .text
                                  //           .bold
                                  //           .color(Vx.gray700)
                                  //           .make(),
                                  //     ],
                                  //   ),
                                  // ),
                                  //create a tabbar with catogries
                                ],
                              ),
                            ),
                            Builder(builder: (context) {
                              if (widget.keyword.isNotEmpty) {
                                var products = searchController.search(
                                    keyword: widget.keyword,
                                    categories: state.resultDataModel!
                                        .productOutsideCategory!);
                                return GridView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: index,
                                    childAspectRatio: 309/510,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    var product = products[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => ProductDetailsScreen(
                                              idBrand:
                                                  product.brandId?.toInt() ?? 0,
                                            ));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                              color: kBackgroundColor
                                                  .withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Spacer(),
                                                    Text(
                                                      product.brandName!,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                  itemCount: products.length,
                                );
                              }
                              return const Center(
                                child: Text("Không tìm thấy sản phẩm"),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
          Get.to(
            () => const ScreenLayout(),
            duration: const Duration(milliseconds: 500),
          );
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
        child: TextField(
          onChanged: (value) {},
          readOnly: true,
          onTap: () {
            Get.to(
                () => const SearchScreen(
                    // keyword: widget.keyword,
                    ),
                arguments: widget.keyword);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
              hintText: widget.keyword,
              border: InputBorder.none),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.grey[700]),
          onPressed: () {
            Get.to(() => const CartScreen(),
                transition: transitions.Transition.rightToLeft);
          },
        ),
      ],
    );
  }

  Widget _drawer(BuildContext context, FilterCubit filterBloc) {
    final padding = MediaQuery.of(context).padding;
    return Drawer(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.only(top: padding.top),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
                child: Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding / 4),
                  child: Text(
                    "Bộ lọc",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 32,
                        child: const Padding(
                          padding: EdgeInsets.only(left: kDefaultPadding / 4),
                          child: Text(
                            "Danh mục sản phẩm",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              for (var categoryFilter in state.categoryFilters!)
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Row(
                                    children: [
                                      Text(
                                        categoryFilter.name,
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 25,
                                        child: Checkbox(
                                          value: categoryFilter.isSelected,
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              categoryFilter.isSelected =
                                                  newValue;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                color: Colors.white,
                height: 48,
                child: FlatButton(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Áp dụng",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
