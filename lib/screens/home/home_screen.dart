import 'package:flutter/material.dart';
import 'package:lixshop/screens/home/home_screen_banner.dart';
import 'package:lixshop/screens/home/home_screen_products_type.dart';
import 'package:lixshop/screens/home/products_show_card.dart';
import 'package:lixshop/screens/product/products_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/search_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Vx.red700,
        onPressed: () {},
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const SearchCard(),
            5.heightBox,
            buildLocation(context),
            10.heightBox,
            const HomeScreenBanner(),
            10.heightBox,
            buildRestaurantRow("", context),
            const HomeScreenProductsType(),
            10.heightBox,
            buildRestaurantRow("Khuyến mãi", context),
            const ProductShowCard(),
            10.heightBox,
            buildRestaurantRow("Sản phẩm bán chạy", context),
            const ProductShowCard(),
            10.heightBox,
            buildRestaurantRow("Sản phẩm mới", context),
            const ProductShowCard(),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}

buildRestaurantRow(String restaurant, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          restaurant,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        FlatButton(
          child: Text(
            "Xem thêm (9)",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ProductsScreen();
                },
                settings: const RouteSettings(name: '/products'),
              ),
            );
          },
        ),
      ],
    ),
  );
}

buildLocation(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    // alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Vx.green700,
            ),
            5.widthBox,
            "Giao tới: Số 3, đường số 2, khu phố 4,..."
                .text
                .bold
                .size(16)
                .green700
                .make(),
          ],
        ),
        // 64.widthBox,
        const Icon(
          Icons.arrow_drop_down,
          color: Vx.green700,
        ),
      ],
    ),
  );
}
