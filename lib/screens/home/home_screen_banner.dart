import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/restaurants.dart';
import '../../widgets/slide_item.dart';

class HomeScreenBanner extends StatefulWidget {
  const HomeScreenBanner({Key? key}) : super(key: key);

  @override
  State<HomeScreenBanner> createState() => _HomeScreenBannerState();
}

class _HomeScreenBannerState extends State<HomeScreenBanner> with TickerProviderStateMixin{
  final CarouselController _controller = CarouselController();

  int _currentIndex = 0;

  List<Widget> restaurantList(BuildContext context) {
    return restaurants.map((restaurant) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SlideItem(
              img: restaurant["img"],
              title: restaurant["title"],
              address: restaurant["address"],
              rating: restaurant["rating"],
            ),
          ),
        ),
      );
    }).toList();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 310,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: restaurantList(context).map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return item;
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: map<Widget>(
                restaurants,
                    (index, url) {
                  return InkWell(
                    onTap: () => _controller.animateToPage(index),
                    child: Container(
                      width: _currentIndex == index ? 40.0 : 15.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: _currentIndex == index ? Vx.green700 : Colors.grey,
                        shape: _currentIndex == index
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                        borderRadius: _currentIndex == index
                            ? const BorderRadius.all(Radius.circular(8.0))
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
