import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/productlist.dart';
import '../../responsive/responsive_screen.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class ProductsScreen extends StatefulWidget {
  final String? keyword;

  const ProductsScreen({Key? key, this.keyword = ""}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          color: DesignCourseAppTheme.notWhite,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "100 sản phẩm".text.bold.size(16).make(),
                            Row(
                              children: [
                                CustomDropdownButton2(
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
                                  value: 'Giá cao tới thấp',
                                  onChanged: (String? value) {},
                                  dropdownItems: const [
                                    "Tất cả",
                                    "Mới nhất",
                                    "Cũ nhất",
                                    "Giá thấp tới cao",
                                    "Giá cao tới thấp",
                                    "Tên A-Z",
                                    "Tên Z-A",
                                  ],
                                ),
                                8.widthBox,
                                Wrap(
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
                              ],
                            )
                          ],
                        ),
                      ),
                      AlignedGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          Map restaurant = restaurants[index];
                          return ProductCardItem(
                            img: restaurant['img'],
                            title: restaurant['title'],
                          );
                        },
                        itemCount: restaurants.length,
                      ),
                    ],
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
            () => const MobileScreenLayout(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      title: InkWell(
        onTap: () {
          Get.to(() => SearchScreen(
                keyword: widget.keyword,
              ));
        },
        child: IgnorePointer(
          child: Container(
            width: double.infinity,
            // height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: widget.keyword ?? 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.grey[700]),
          onPressed: () {},
        ),
      ],
    );
  }
}
