import 'package:flutter/material.dart';
import 'package:lixshop/widgets/test_canva.dart';

class TestContainer extends StatelessWidget {
  const TestContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: DecoPainter(),
        child: const SizedBox(
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
