import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';
import '../core/core.dart';
import '../core/cubits/bottom_navigation/navigation_state.dart';
import '../screens/auth/login_screen.dart';
import '../screens/introduction_animation/introduction_animation_screen.dart';
import '../utils/global_variable.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout>
    with TickerProviderStateMixin<ScreenLayout> {
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

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
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
            body: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                return Center(
                  child: homeScreenItems.elementAt(
                      BlocProvider.of<NavigationCubit>(context).state.index),
                );
              },
            ),
            bottomNavigationBar: _bottomNavigation(context, authBloc),
          );
  }

  Widget _bottomNavigation(BuildContext context, final authBloc) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: creamColor.withOpacity(0.1),
            gap: 8,
            activeColor: Vx.red600,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 200),
            tabBackgroundColor: Colors.transparent,
            color: Vx.gray600,
            tabs: _navItems(),
            tabBorderRadius: 8,
            selectedIndex: state.index,
            textStyle: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Vx.red600),
            onTabChange: (index) async {
              if (index == 3 && authBloc.state is LogoutAuthState) {
                Get.to(() => const LoginScreen());
              } else {
                BlocProvider.of<NavigationCubit>(context)
                    .changeNavigation(index);
              }
            },
          ),
        );
      },
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
