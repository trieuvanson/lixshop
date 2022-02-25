
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/restaurants.dart';
import '../widgets/search_card.dart';
import '../widgets/slide_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
  Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  static final List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    setState(() {
      refreshNum = Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      // ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
      //   SnackBar(
      //     content: const Text('Refresh complete'),
      //     action: SnackBarAction(
      //       label: 'RETRY',
      //       onPressed: () {
      //         _refreshIndicatorKey.currentState!.show();
      //       },
      //     ),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: () => _handleRefresh(),
        animSpeedFactor: 5.0,
        color: Colors.transparent,
        backgroundColor: Vx.indigo500,
        showChildOpacityTransition: false,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView(
              children: <Widget>[
                buildSearchBar(context),
                20.heightBox,
                buildRestaurantRow('Trending Restaurants', context),
                10.heightBox,
                buildRestaurantList(context),
                // SizedBox(height: 10.0),
                // buildCategoryRow('Category', context),
                // SizedBox(height: 10.0),
                // buildCategoryList(context),
                // SizedBox(height: 20.0),
                // buildCategoryRow('Friends', context),
                // SizedBox(height: 10.0),
                // buildFriendsList(),
                // SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
        // child: StreamBuilder<int>(
        //   stream: counterStream,
        //   builder: (context, snapshot) {
        //     return ListView.builder(
        //       padding: kMaterialListPadding,
        //       itemCount: _items.length,
        //       controller: _scrollController,
        //       itemBuilder: (BuildContext context, int index) {
        //         final String item = _items[index];
        //         return ListTile(
        //           isThreeLine: true,
        //           leading: CircleAvatar(child: Text(item)),
        //           title: Text('This item represents $item.'),
        //           subtitle: Text(
        //               'Even more additional list item information appears on line three. ${snapshot.data}'),
        //         );
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }

  buildSearchBar(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: SearchCard()
    );
  }

  buildRestaurantRow(String restaurant, BuildContext context) {
    return Row(
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
            "See all (9)",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return "ABC".text.make();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  buildRestaurantList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: restaurants == null ? 0 : restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          Map restaurant = restaurants[index];

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SlideItem(
              img: restaurant["img"],
              title: restaurant["title"],
              address: restaurant["address"],
              rating: restaurant["rating"],
            ),
          );
        },
      ),
    );
  }}
