import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lixshop/models/restaurants.dart';
import 'package:lixshop/widgets/slide_item.dart';
import 'package:velocity_x/velocity_x.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final CarouselController _controller = CarouselController();

  int _currentIndex = 0;

  List restaurantList = restaurants
      .map((restaurant) => Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SlideItem(
              img: restaurant["img"],
              title: restaurant["title"],
              address: restaurant["address"],
              rating: restaurant["rating"],
            ),
          ))
      .toList();

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
              height: MediaQuery.of(context).size.height / 2.3,
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
            items: restaurantList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return item;
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: map<Widget>(
              restaurants,
              (index, url) {
                return InkWell(
                  onTap: () => _controller.animateToPage(index),
                  child: Container(
                    padding: EdgeInsets.zero,
                    width: _currentIndex == index ? 40.0 : 15.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Vx.green700
                          : Colors.grey,
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
        ],
      ),
    );
  }
}
