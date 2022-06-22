import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screen.dart';
import '../constants/get_started_controller.dart';
import '../constants/global.dart';
import '4next_back_button.dart';

class BuildGetStartedButton extends StatefulWidget {
  final BuildContext context;
  const BuildGetStartedButton({Key? key, required this.context}) : super(key: key);

  @override
  State<BuildGetStartedButton> createState() => _BuildGetStartedButtonState();
}

class _BuildGetStartedButtonState extends State<BuildGetStartedButton> {

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
  Widget build(context) {
    return currentPage.value == 3
        ? SizedBox(
      width: (MediaQuery.of(context).size.width) - 25,
      // height: 50,
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.00),
              ),
            ),
            child: const Text(
              "Đăng nhập",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.00,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () async {
              SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isFirstTime', true);
                      Get.offAll(
                        () => const LoginScreen(),
                        transition: Transition.rightToLeft,
                      );
                    }
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.00),
              ),
            ),
            child: Text(
              "Đăng ký",
              style: TextStyle(
                color: primaryColor,
                fontSize: 25.00,
                fontWeight: FontWeight.w500,
              ),
            ),
              onPressed: () async {
                SharedPreferences prefs =
                await SharedPreferences.getInstance();
                prefs.setBool('isFirstTime', true);
                Get.offAll(
                      () => const RegisterScreen(),
                  transition: Transition.rightToLeft,
                );
              },
          ),
        ],
      ),
    )
        : buildNextBackBtn(currentPage.value.toDouble());
  }
}

Widget buildGetStartedButton(BuildContext context) => currentPage.value == 3
    ? SizedBox(
        width: (MediaQuery.of(context).size.width) - 25,
        // height: 50,
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.00),
                ),
              ),
              child: const Text(
                "Đăng nhập",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.00,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {

              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.00),
                ),
              ),
              child: Text(
                "Đăng ký",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 25.00,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {

              },
            ),
          ],
        ),
      )
    : buildNextBackBtn(currentPage.value.toDouble());
