import 'package:flutter/material.dart';

import '../constants/get_started_controller.dart';
import '../constants/global.dart';
import '../constants/image_files.dart';
import '../constants/widgets_controller.dart';


class BuildPageView extends StatelessWidget {
  const BuildPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.55,
      child: PageView.builder(
        controller: myPageViewController,
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildTopViews(context, index);
        },
        onPageChanged: (value) {
          try {
            currentPage.value = value.toDouble();
          } catch (e) {
            
          }
        },
      ),
    );
  }
  Widget buildTopViews(BuildContext context, int index) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.00),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildImage(index),
        heightSpacer(25.00),
        buildTitle(index),
        heightSpacer(10.00),
        buildSubTitle(context, index),
      ],
    ),
  );

  Widget buildImage(int index) => Center(
    child: SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.asset(
        getStartedPageImages[index],
        fit: BoxFit.contain,
      ),
    ),
  );

  Widget buildTitle(int index) => Flexible(
    child: Text(
      heading[index],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: primaryColor,
        fontSize: 20.00,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget buildSubTitle(BuildContext context, int index) => Flexible(
    child: SizedBox(
      width: (MediaQuery.of(context).size.width) - 100,
      child: Text(
        subHeading[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 12.75,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}



// Widget buildPageView(BuildContext context) => SizedBox(
//       height: MediaQuery.of(context).size.height / 1.55,
//       child: PageView.builder(
//         controller: myPageViewController,
//         itemCount: 4,
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (context, index) {
//           return buildTopViews(context, index);
//         },
//         onPageChanged: (value) {
//           try {
//             currentPage.value = value.toDouble();
//           } catch (e) {}
//         },
//       ),
//     );
//
// Widget buildTopViews(BuildContext context, int index) => Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50.00),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           buildImage(index),
//           heightSpacer(25.00),
//           buildTitle(index),
//           heightSpacer(10.00),
//           buildSubTitle(context, index),
//         ],
//       ),
//     );
//
// Widget buildImage(int index) => Center(
//       child: SizedBox(
//         width: double.infinity,
//         height: 200,
//         child: Image.asset(
//           getStartedPageImages[index],
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//
// Widget buildTitle(int index) => Flexible(
//       child: Text(
//         heading[index],
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 20.00,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//
// Widget buildSubTitle(BuildContext context, int index) => Flexible(
//       child: SizedBox(
//         width: (MediaQuery.of(context).size.width) - 100,
//         child: Text(
//           subHeading[index],
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             color: Colors.blueGrey,
//             fontSize: 12.75,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
