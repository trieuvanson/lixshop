import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/screens/product/products_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';

class SearchScreen extends StatefulWidget {
  String? keyword;

  SearchScreen({Key? key, this.keyword = ""}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(),
        body: widget.keyword!.trim().isNotEmpty
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
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            Get.focusScope!.unfocus();
          } else {
            Get.back();
          }
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
            autofocus: true,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Get.to(
                  () => ProductsScreen(keyword: value),
                  routeName: '/products?keyword=$value',
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 300),
                );
              }
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: widget.keyword!.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            widget.keyword = "";
                          });
                        },
                      )
                    : null,
                hintText: widget.keyword ?? 'Search...',
                border: InputBorder.none),
            onChanged: (value) {
              setState(() {
                widget.keyword = value;
              });
            }),
      ),
    );
  }

  Widget keyWordSearchNotEmpty() {
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
                  for (var i = 0; i < 10; i++)
                    _MenuItem(
                        title: "${widget.keyword} $i",
                        onTap: () {
                          Get.to(
                            () =>
                                ProductsScreen(keyword: "${widget.keyword} $i"),
                            routeName: '/products?keyword=${widget.keyword} $i',
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 300),
                          );
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget keyWordSearchIsEmpty() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: "Tìm kiếm phổ biến".text.xl2.bold.make(),
                  ),
                  Container()
                ],
              ),
              10.heightBox,
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.symmetric(vertical: 10),
                childAspectRatio: 3,
                children: [
                  for (var i = 0; i < 10; i++)
                    Container(
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
                              () => ProductsScreen(
                                  keyword: "Tìm kiếm phổ biến ${i + 1}"),
                              routeName:
                                  '/products?keyword=Tìm kiếm phổ biến ${i + 1}',
                              transition: Transition.downToUp,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 30,
                              ),
                              "Tìm kiếm phổ biến ${i + 1}".text.make(),
                            ],
                          ),
                        ),
                      ),
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

class _MenuItem extends StatelessWidget {
  final String title;
  final Widget? subTitle;
  final GestureTapCallback? onTap;

  const _MenuItem({Key? key, required this.title, this.subTitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {
          print(title);
            },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: title.text
                      .size(16)
                      .gray700
                      .overflow(TextOverflow.ellipsis)
                      .make()),
              Row(
                children: [
                  subTitle ?? const SizedBox.shrink(),
                  InkWell(
                    onTap: () {
                      print(title);
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Vx.gray500,
                      size: 20,
                    ),
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
