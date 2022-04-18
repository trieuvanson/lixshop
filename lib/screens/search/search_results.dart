import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transitions;
import 'package:lixshop/constants/contains.dart';
import 'package:lixshop/core/core.dart';
import 'package:lixshop/core/cubits/filter/filter_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/search_controller.dart';
import '../../models/filters/category_filter.dart';
import '../../models/models.dart';
import '../../responsive/screen_layout.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
   List<ProductOutsideCategory> categories = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<ResultOutsideCubit>(context).getProductOutside();

    super.initState();
  }

  @override
  @override
  void dispose() {
    setState(() {
      BlocProvider.of<ResultOutsideCubit>(context).close();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterBloc = BlocProvider.of<FilterCubit>(context);
    final resultDataBloc = BlocProvider.of<ResultOutsideCubit>(context);
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: _drawer(context, filterBloc),
      ),
      appBar: appBar(),
      body: BlocListener<ResultOutsideCubit, ResultOutsideState>(
        listener: (context, state) {
          if (state.isSuccess) {
            print('Rerender');
            categories = state.resultDataModel!.productOutsideCategory!;
            List<CategoryFilter> categoryFilters = state
                .resultDataModel!.productOutsideCategory!
                .map((e) => CategoryFilter(id: e.cateId!, name: e.cateName!))
                .toList();
            filterBloc.setCategory([...categoryFilters]);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            color: DesignCourseAppTheme.notWhite,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 8),
              child: SingleChildScrollView(
                child: Container(
                  color: DesignCourseAppTheme.notWhite,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 12, right: 12, bottom: 8),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16, top: 16),
                          width: double.infinity,
                          child: Row(
                            children: [
                              "${213} sản phẩm".text.bold.size(16).make(),
                              const Spacer(),
                              CustomDropdownButton2(
                                dropdownWidth: 100,
                                buttonWidth: 120,
                                buttonDecoration: BoxDecoration(
                                  color: DesignCourseAppTheme.nearlyWhite,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  border: Border.all(
                                    color: Vx.gray300,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                ),
                                hint: 'Đơn vị tính',
                                value: 'Tất cả',
                                onChanged: (String? value) {},
                                dropdownItems: const [
                                  "Tất cả",
                                  "Tên A-Z",
                                  "Tên Z-A",
                                ],
                              ),
                              8.widthBox,
                              InkWell(
                                onTap: () {
                                  scaffoldKey.currentState?.openEndDrawer();
                                },
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.filter_list,
                                      color: Vx.gray700,
                                    ),
                                    "Lọc".text.bold.color(Vx.gray700).make(),
                                  ],
                                ),
                              ),
                              //create a tabbar with catogries
                            ],
                          ),
                        ),

                        // BlocBuilder<FilterCubit, FilterState>(
                        //   builder: (context, state) {
                        //     if (state.keyword!.isNotEmpty &&
                        //         state.categoryFilters!.isNotEmpty) {
                        //       var productCategories = searchController.searchByKeyword(
                        //           state.keyword!, categories);
                        //       var products = searchController.getByCategories(productCategories);
                        //       final size = MediaQuery.of(context).size;
                        //
                        //       return Container(
                        //         width: 200,
                        //         height: 200,
                        //         color: Colors.red,
                        //       );
                        //     }
                        //     return Container();
                        //   },
                        // ),

                        //tab bar categories
                           BlocBuilder<FilterCubit, FilterState>(
                          builder: (context, state) {
                            if (state.keyword!.isNotEmpty &&
                                state.categoryFilters!.isNotEmpty) {
                              var productCategories = searchController.searchAndFilter(
                                          keyword: state.keyword!, categories: categories, filter: state.categoryFilters!);
                              var products =
                                  searchController.getByCategories(productCategories);
                              return AlignedGridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ProductCardItem(
                                    product: products[index],
                                  );
                                },
                                itemCount: products.length,
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
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
        child: BlocBuilder<FilterCubit, FilterState>(
          builder: (context, state) {
            return TextField(
              onChanged: (value) {},
              readOnly: true,
              onTap: () {
                Get.to(() => const SearchScreen(
                    // keyword: widget.keyword,
                    ));
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                  hintText: state.keyword ?? 'Search...',
                  border: InputBorder.none),
            );
          },
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

  Widget _drawer(BuildContext context, FilterCubit  filterBloc) {
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
