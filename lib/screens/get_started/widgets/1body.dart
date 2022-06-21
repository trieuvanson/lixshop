import 'package:flutter/material.dart';
import '../constants/get_started_controller.dart';
import '../constants/widgets_controller.dart';
import '5get_started_button.dart';
import '3dot_indicator.dart';
import '2page_view.dart';

Widget buildBody(BuildContext context) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: (MediaQuery.of(context).size.height)),
        child: ValueListenableBuilder<double>(
          valueListenable: currentPage,
          builder: (context, value, _) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildPageView(context),
                  heightSpacer(30.00),
                  buildDotIndicator(),
                  heightSpacer(100.00),
                  const Spacer(),
                  buildGetStartedButton(context),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
