import 'package:flutter/material.dart';
import 'package:lixshop/screens/login_screen.dart';
import 'package:lixshop/widgets/restaurants_list.dart';
import 'package:lixshop/widgets/test.dart';

import '../screens/add_post_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  // const TestContainer(),
  // const Text('notifications'),
  LoginScreen(),
  const RestaurantList(),
  const ProfileScreen(
  ),
];
