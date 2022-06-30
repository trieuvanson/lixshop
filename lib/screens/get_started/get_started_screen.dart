import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BuildBody(),
    );
  }
}
