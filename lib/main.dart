import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lixshop/core/cubits/filter/filter_cubit.dart';
import 'package:lixshop/core/cubits/product_details/result_details_data_cubit.dart';
import 'package:lixshop/main_screen.dart';
import 'package:url_strategy/url_strategy.dart';

import '../../core/core.dart';
import 'app_bloc_observer.dart';
import 'constants/contains.dart';
import 'screen_layout.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dotenv.load(fileName: ".env");
  setPathUrlStrategy();
  BlocOverrides.runZoned(
    () {
      // runApp(
      //   DevicePreview(
      //     enabled: !kReleaseMode,
      //     tools: const [
      //       ...DevicePreview.defaultTools,
      //     ],
      //     builder: (context) => const LixShop(),
      //   ),
      // );
      runApp(
        const LixShop(),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}

class LixShop extends StatelessWidget {
  const LixShop({Key? key}) : super(key: key);

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
        BlocProvider<ResultDetailsDataCubit>(
            create: (context) => ResultDetailsDataCubit()),
        BlocProvider<FilterCubit>(create: (context) => FilterCubit()),
      ],
      child: GetMaterialApp(
        title: 'Lix Shop',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          primarySwatch: MaterialColor(kPrimaryColor.value, kPrimaryColorMap),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: GoogleFonts.poppins().fontFamily,
                bodyColor: kTextColor,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark(),
        home: const ScreenLayout(),
        // routes: {
        //   '/': (context) => const MainScreen(),
        // },
        // onGenerateRoute: RouteSettingsWithArguments.generateRoute,
      ),
    );
  }
}

class RouteSettingsWithArguments extends RouteSettings {
  final RouteSettings settings;

  const RouteSettingsWithArguments({
    required this.settings,
  });

  @override
  String? get name => settings.name;

  @override
  dynamic get arguments => settings.arguments;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const ScreenLayout());
      default:
        return MaterialPageRoute(
            builder: (_) => const NotFound(
                  message: '404 NOT FOUND\n'
                      'Không tìm thấy trang này.\n',
                ));
    }
  }
}

class NotFound extends StatelessWidget {
  final String? message;

  const NotFound({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(message!)),
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
