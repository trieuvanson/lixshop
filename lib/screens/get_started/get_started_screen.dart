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
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      print('Ahihi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BuildBody(),
    );
  }
}
