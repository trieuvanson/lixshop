import 'package:flutter/material.dart';
import 'package:lixshop/screens/profile/profile_screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const ProfileScreen(),

];
