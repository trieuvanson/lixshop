import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lixshop/main_screen.dart';
import 'package:lixshop/models/models.dart';

import '../../screen_layout.dart';
import '../../utils/design_course_app_theme.dart';
import '../../widgets/widgets.dart';

class ProductsTypeScreen extends StatefulWidget {
  final List<ProductOutsideBrand> products;

  const ProductsTypeScreen({Key? key, required this.products})
      : super(key: key);

  @override
  State<ProductsTypeScreen> createState() => _ProductsTypeScreenState();
}

class _ProductsTypeScreenState extends State<ProductsTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
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
                      AlignedGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var product = widget.products[index];
                          return ProductCardItem(
                            product: product,
                          );
                        },
                        itemCount: widget.products.length,
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

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      leadingWidth: 30,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.to(
            () => const MainScreen(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
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
