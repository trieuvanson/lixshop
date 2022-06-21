import 'package:flutter/material.dart';
import '../constants/get_started_controller.dart';
import '../constants/global.dart';
import '4next_back_button.dart';

Widget buildGetStartedButton(BuildContext context) => currentPage.value == 3
    ? SizedBox(
        width: (MediaQuery.of(context).size.width) - 25,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.00),
            ),
          ),
          child: const Text(
            "Get Started",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.00,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {},
        ),
      )
    : buildNextbackBtn(currentPage.value.toDouble());
