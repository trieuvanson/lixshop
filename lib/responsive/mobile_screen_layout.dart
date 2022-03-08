import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../contains/colors.dart';
import '../screens/introduction_animation/introduction_animation_screen.dart';
import '../utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout>  with TickerProviderStateMixin<MobileScreenLayout>{
  //
  // int _currentIndex = 0;
  //  late PageController _pageController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController();
  // }
  //
  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Bottom Nav Bar")),
  //     body: SizedBox.expand(
  //       child: PageView(
  //         controller: _pageController,
  //         onPageChanged: (index) {
  //           setState(() => _currentIndex = index);
  //         },
  //         children: <Widget>[
  //           Container(color: Colors.blueGrey,),
  //           Container(color: Colors.red,),
  //           Container(color: Colors.green,),
  //           Container(color: Colors.blue,),
  //         ],
  //       ),
  //     ),
  //     bottomNavigationBar: BottomNavyBar(
  //       selectedIndex: _currentIndex,
  //       onItemSelected: (index) {
  //         setState(() => _currentIndex = index);
  //         _pageController.jumpToPage(index);
  //       },
  //       items: <BottomNavyBarItem>[
  //         BottomNavyBarItem(
  //             title: const Text('Item One'),
  //             icon: const Icon(Icons.home)
  //         ),
  //         BottomNavyBarItem(
  //             title: Text('Item Two'),
  //             icon: const Icon(Icons.apps)
  //         ),
  //         BottomNavyBarItem(
  //             title: const Text('Item Three'),
  //             icon: const Icon(Icons.chat_bubble)
  //         ),
  //         BottomNavyBarItem(
  //             title: const Text('Item Four'),
  //             icon: const Icon(Icons.settings)
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
    print('isFirstTime2: $checkFirstTime');
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
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(
        //   color: creamColor,
        //   boxShadow: [
        //     BoxShadow(
        //         blurRadius: 20,
        //       color: Colors.black.withOpacity(.1),
        //     )
        //   ],
        // ),
        child: SafeArea(
          child: Padding(
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
              selectedIndex: _selectedIndex,
              textStyle: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Vx.red600),
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
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
