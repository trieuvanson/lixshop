  import 'package:flutter/material.dart';
  import 'package:velocity_x/velocity_x.dart';

  class WebScreenLayout extends StatelessWidget {
    const WebScreenLayout({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: "This is a web screen layout".text.makeCentered(),
      );
    }
  }
