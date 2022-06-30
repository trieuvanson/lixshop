import 'package:flutter/material.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'main_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/get_started/get_started_screen.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout>
    with TickerProviderStateMixin<ScreenLayout> {
  bool? checkFirstTime;
  bool isLogin = false;
  bool _isLoading = true;

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  checkFirstSeen() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // checkFirstTime = (prefs.getBool('isFirstTime') ?? false);
    // isLogin = await secureStorage.checkLogin();
    // isLogin ? _isLoading = false : _isLoading = true;
    // setState(() {});
    // await Future.delayed(const Duration(seconds: 3));
    // if (!checkFirstTime!) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (context) => const GetStartedScreens(),
    //     ),
    //     (route) => false,
    //   );
    // } else {
    //   checkLogin();
    // }
    checkLogin();
    _isLoading = false;
    setState(() {});
  }

  checkLogin() async {
    if (!isLogin) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.green500,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              Image.asset(
                'assets/logos/lixco_logo.png',
                width: 100,
              ),
              const Text(
                'Lixco xin chào!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Vx.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
