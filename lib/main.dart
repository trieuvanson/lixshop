import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:url_strategy/url_strategy.dart';

import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/product/product_detail_screen.dart';
import 'screens/product/products_screen.dart';
import 'screens/auth/register_screen.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        "/forgot-password": (_) => ForgotPasswordScreen(),
        "/test": (_) => const ProductsScreen(),
        "/products": (_) => const ProductsScreen(),
        "/product-detail": (_) => const ProductDetailScreen(),
      },
    );
  }
}

//            Stack(
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   physics: const BouncingScrollPhysics(),
//                   controller: _scrollController,
//                   child: Row(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width - 120,
//                         height: 100,
//                         color: Colors.red,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width - 120,
//                         height: 100,
//                         color: Colors.green,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width - 120,
//                         height: 100,
//                         color: Colors.blue,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width - 120,
//                         height: 100,
//                         color: Colors.red,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width - 120,
//                         height: 100,
//                         color: Colors.green,
//                       ),
//                       Padding(padding: EdgeInsets.only(right: 120)),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: Container(
//                     color: Colors.white,
//                     width: 120,
//                     height: 100,
//                     child: Center(
//                       child: IconButton(
//                         onPressed: () {
//                           double currentPosition = _scrollController.offset;
//                           if (currentPosition ==
//                               _scrollController.position.maxScrollExtent) {
//                             _scrollController.animateTo(
//                                 currentPosition -=
//                                     (MediaQuery.of(context).size.width - 120),
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease);
//                           } else {
//                             _scrollController.animateTo(
//                                 currentPosition +=
//                                     (MediaQuery.of(context).size.width - 120),
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.ease);
//                           }
//
//                           print(_scrollController.offset);
//                         },
//                         icon: !(_scrollController.position.maxScrollExtent ==
//                                 _scrollController.offset)
//                             ? const Icon(Icons.skip_next)
//                             : const Icon(Icons.skip_previous),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
