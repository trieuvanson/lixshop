import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../screen.dart';
import '../constants/get_started_controller.dart';
import '../constants/widgets_controller.dart';
import '5get_started_button.dart';
import '3dot_indicator.dart';
import '2page_view.dart';

class BuildBody extends StatefulWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  onLoginClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('isFirstTime', true);
    print('Click');
    setState(() {});
    Get.to(
      () => const LoginScreen(),
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: currentPage,
      builder: (context, value, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BuildPageView(),
              30.heightBox,
              buildDotIndicator(),
              100.heightBox,
              const Spacer(),
              BuildGetStartedButton(context: context),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}

// Widget buildBody(BuildContext context) => ValueListenableBuilder<double>(
//       valueListenable: currentPage,
//       builder: (context, value, _) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               buildPageView(context),
//               heightSpacer(30.00),
//               buildDotIndicator(),
//               heightSpacer(100.00),
//               const Spacer(),
//               buildGetStartedButton(context),
//               const Spacer(),
//             ],
//           ),
//         );
//       },
//     );
