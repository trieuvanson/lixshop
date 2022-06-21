import 'package:flutter/material.dart';

import '../constants/get_started_controller.dart';
import '../constants/global.dart';


Widget buildNextbackBtn(double currentPage) => SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentPage != 0
                ? GestureDetector(
                    onTap: () {
                      myPageViewController.previousPage(
                          duration: const Duration(seconds: 1), curve: Curves.ease);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.navigate_before),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            GestureDetector(
              onTap: () {
                myPageViewController.nextPage(
                    duration: const Duration(seconds: 1), curve: Curves.ease);
              },
              child: Row(
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
