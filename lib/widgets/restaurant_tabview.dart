import 'package:flutter/material.dart';
import 'package:lixshop/models/restaurants.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({Key? key}) : super(key: key);

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = -1;

  @override
  void initState() {
    _tabController = TabController(length: restaurants.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: restaurants.length,
      initialIndex: 0,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey[300],
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: TabBar(
          enableFeedback: true,
          isScrollable: true,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              _tabController!.animateTo(index);
            });
          },
          controller: _tabController,
          // give the indicator a decoration (color and border radius)
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            color: Colors.green,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: List<Widget>.generate(
            restaurants.length,
            (index) {
              return Tab(
                height: 100,
                child: Text(
                  restaurants[index]['title'],
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                icon: Image.asset(restaurants[index]['img'],
                    width: 100, height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
