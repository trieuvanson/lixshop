import 'package:flutter/material.dart';
import 'package:lixshop/screens/profile/profile_screen.dart';
import 'package:lixshop/screens/screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/home/home_screen.dart' as home;
import '../screens/home1/home_screen.dart' as home1;
import '../screens/notification/notification_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const home1.HomeScreen(),
  // const home.HomeScreen(),
  // const ProfileClientPage(),

  // const ProductDetailsScreen(),
  // CheckingLoginPage(),
  // const ProfileClientPage(),

  const AddPostScreen(),
  const NotificationScreen(),
  const ProfileScreen(),
];
