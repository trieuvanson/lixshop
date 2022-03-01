import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lixshop/responsive/mobile_screen_layout.dart';
import 'package:lixshop/responsive/responsive_layout_screen.dart';
import 'package:lixshop/responsive/web_screen_layout.dart';
import 'package:lixshop/screens/login_screen.dart';
import 'package:lixshop/screens/register_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lix Shop',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFFFFC107),
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: "/",
      // home: const LoadingScreen(),
      routes: {
        '/': (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout()),
        '/login': (_) => LoginScreen(),
        '/register': (_) => RegisterScreen(),
      },
    );
  }
}
