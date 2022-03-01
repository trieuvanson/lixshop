import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/responsive/web_screen_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../contains/dimensions.dart';
import '../screens/introduction_animation/introduction_animation_screen.dart';
import 'mobile_screen_layout.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout>
    with TickerProviderStateMixin<ResponsiveLayout> {
  bool? checkFirstTime = false;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkFirstTime = (prefs.getBool('isFirstTime') ?? false);
    setState(() {});
    if (!checkFirstTime!) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroductionAnimationScreen(),
        ),
      );
    }
    print('isFirstTime2: $checkFirstTime');
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !checkFirstTime!
        ? Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > webScreenSize) {
                // Web Screen
                return widget.webScreenLayout;
              }
              // Mobile Screen
              return widget.mobileScreenLayout;
            },
          );
  }
}
