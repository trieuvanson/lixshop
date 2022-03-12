import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../contains/colors.dart';
import '../screens/auth/login_screen.dart';
import '../screens/introduction_animation/introduction_animation_screen.dart';
import '../utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout>
    with TickerProviderStateMixin<MobileScreenLayout> {
  int _selectedIndex = 0;

  bool? checkFirstTime = false;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkFirstTime = (prefs.getBool('isFirstTime') ?? false);
    setState(() {});
    if (!checkFirstTime!) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroductionAnimationScreen(),
        ),
      );
    }
  }

  bool isLogin = false;

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = (prefs.getBool('isLogin') ?? false);
    if (!isLogin) {
      Get.to(() => LoginScreen());
    }
    setState(() {});
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !checkFirstTime!
        ? Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: homeScreenItems.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: creamColor.withOpacity(0.1),
                  gap: 8,
                  activeColor: Vx.red600,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 200),
                  tabBackgroundColor: Colors.transparent,
                  color: Vx.gray600,
                  tabs: _navItems(),
                  tabBorderRadius: 8,
                  selectedIndex: _selectedIndex,
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Vx.red600),
                  onTabChange: (index) {
                    if (!isLogin && index == 3) {
                      setState(() {
                        _selectedIndex = index;
                        checkLogin();
                      });
                    } else {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
                  },
                ),
              ),
            ),
          );
  }

  static List<GButton> _navItems() {
    return const [
      GButton(
        icon: LineIcons.home,
        text: 'Trang chủ',
      ),
      GButton(
        icon: Icons.notifications_none,
        text: 'Thông báo',
      ),
      GButton(
        icon: Icons.message_outlined,
        text: 'Hộp thư',
      ),
      GButton(
        icon: LineIcons.user,
        text: 'Cá nhân',
      ),
    ];
  }
}
