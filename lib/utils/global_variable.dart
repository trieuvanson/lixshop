import 'package:flutter/material.dart';
import 'package:lixshop/screens/CheckingLoginPage.dart';
import 'package:lixshop/screens/profile/profile_screen.dart';
import 'package:lixshop/screens/screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/comments_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/notification/notification_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeScreen(),
  // const ProfileClientPage(),

  const NotificationScreen(),
  // const ProductDetailsScreen(),
  // CheckingLoginPage(),
  // const ProfileClientPage(),
  const AddPostScreen(),
  const ProfileScreen(),
];
