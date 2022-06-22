import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen.dart';
import 'widgets/1body.dart';

class GetStartedScreens extends StatefulWidget {
  const GetStartedScreens({Key? key}) : super(key: key);

  @override
  _GetStartedScreensState createState() => _GetStartedScreensState();
}

class _GetStartedScreensState extends State<GetStartedScreens> {
  String? name;
  bool? checkValue;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BuildBody(),
    );
  }
}
