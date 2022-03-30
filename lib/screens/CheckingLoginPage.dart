import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/responsive/mobile_screen_layout.dart';
import 'package:lixshop/screens/auth/login_screen.dart';

import '../blocs/auth/auth_bloc.dart';


class CheckingLoginPage extends StatefulWidget {
  @override
  _CheckingLoginPageState createState() => _CheckingLoginPageState();
}


class _CheckingLoginPageState extends State<CheckingLoginPage> with TickerProviderStateMixin {

  late AnimationController _animationController;
  
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_animationController)..addStatusListener((status) {
      if( status == AnimationStatus.completed ){
        _animationController.reverse();
      } else if ( status == AnimationStatus.dismissed ){
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        print('CheckingLoginPage: ${state.toString()}');

        if( state is LoadingAuthState ){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckingLoginPage()));
        
        }
        if ( state is LogOutAuthState ){

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
         
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MobileScreenLayout()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}