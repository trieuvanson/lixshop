import 'package:flutter/material.dart';
import 'package:lixshop/screens/home/home_screen.dart';
import 'package:lixshop/widgets/slide_item.dart';
import 'package:lixshop/widgets/test_canva.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/restaurants.dart';

class TestContainer extends StatefulWidget {
  const TestContainer({Key? key}) : super(key: key);

  @override
  State<TestContainer> createState() => _TestContainerState();
}

class _TestContainerState extends State<TestContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}
