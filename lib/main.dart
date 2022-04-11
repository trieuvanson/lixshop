import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lixshop/core/cubits/product_details/result_details_data_cubit.dart';
import 'package:url_strategy/url_strategy.dart';

import '../../core/core.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'app_bloc_observer.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dotenv.load(fileName: ".env");
  BlocOverrides.runZoned(
    () {
      runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          tools: const [
            ...DevicePreview.defaultTools,
          ],
          builder: (context) => const MyApp(),
        ),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(
            create: (context) =>
                CheckoutBloc(cartBloc: BlocProvider.of<CartBloc>(context))),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<ResultOutsideCubit>(
          create: (context) => ResultOutsideCubit()..getProductOutside(),
        ),
        BlocProvider<ResultDetailsDataCubit>(create: (context) => ResultDetailsDataCubit()),

      ],
      child: GetMaterialApp(
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
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          "/forgot-password": (_) => const ForgotPasswordScreen(),
          // "/product-detail": (_) => const ProductDetailScreen(),
        },
      ),
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
