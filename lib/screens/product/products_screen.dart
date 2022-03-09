import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:lixshop/models/restaurants.dart';
import 'package:lixshop/screens/product/product_detail_screen.dart';

import '../../widgets/product_card_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.1,
        backgroundColor: Colors.white,
        // automaticallyImplyLeading:
        //     FocusManager.instance.primaryFocus!.hasFocus != null ? false : true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () {
        //     FocusManager.instance.primaryFocus?.unfocus();
        //   },
        // ),
        // // The search area here
        // leading: const Icon(
        //   Icons.arrow_back_ios,
        //   color: Colors.black,
        // ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Container(
          width: double.infinity,
          // height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.grey[700]),
            onPressed: () {
              /* Open the shopping cart */
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: AlignedGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            Map restaurant = restaurants[index];
            return ProductCardItem(
              img: restaurant['img'],
              title: restaurant['title'],
              address: restaurant['address'],
              rating: restaurant['rating'],
            );
          },
          itemCount: restaurants.length,
        ),
        // child: GridView.builder(
        //   physics: const BouncingScrollPhysics(),
        //   padding: const EdgeInsets.all(4.0),
        //   itemCount: restaurants.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     childAspectRatio: 0.501,
        //     mainAxisSpacing: 4.0,
        //     crossAxisSpacing: 4.0,
        //   ),
        //   itemBuilder: (BuildContext context, int index) {
        //     Map restaurant = restaurants[index];
        //     return Container(
        //         constraints: const BoxConstraints(
        //           maxHeight: double.infinity,
        //         ),
        //         // width: MediaQuery.of(context).size.width * 0.5,
        //         decoration: BoxDecoration(
        //           color: Colors.grey[200],
        //           borderRadius: BorderRadius.circular(8),
        //           boxShadow: const [
        //             BoxShadow(
        //               color: Colors.white,
        //               blurRadius: 5.0,
        //               spreadRadius: 1.0,
        //               offset: Offset(
        //                 2.0,
        //                 2.0,
        //               ),
        //             ),
        //           ],
        //         ),
        //         child: ProductCardItem(
        //           img: restaurant['img'],
        //           title: restaurant['title'],
        //           address: restaurant['address'],
        //           rating: restaurant['rating'],
        //         ));
        //   },
        // ),
      ),
    );
  }
}
