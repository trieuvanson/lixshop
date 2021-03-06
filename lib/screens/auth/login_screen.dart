import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/auth/login_model.dart';
import 'package:lixshop/screens/auth/send_forgot_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../../core/core.dart';
import '../../main_screen.dart';
import '../../screen_layout.dart';
import '../../utils/helpers/error_message.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String email = "";
  String password = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      setState(() {});
      Get.to(
        () => const MainScreen(),
        routeName: "/register",
      );
    }
  }

  handleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          setState(() {
            _loading = true;
          });
        } else if (state is FailureAuthState) {
          setState(() {
            _loading = false;
          });
          errorMessageSnack(context, state.error?? "C?? l???i x???y ra, vui l??ng th??? l???i sau!");
        } else if (state is SuccessAuthState) {
          setState(() {
            _loading = false;
          });
          Get.offAll(
            () => const MainScreen(),
          );
        } else {
          setState(() {
            _loading = false;
          });
        }
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor,
          // shadowColor: Colors.transparent,
          elevation: 0,
          // iconTheme: const IconThemeData(color: Vx.black),
          leading: const SizedBox.shrink(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildImageHeader(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                  "S??? ??i???n tho???i"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kh??ng ???????c ????? tr???ng';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        15.heightBox,
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kh??ng ???????c ????? tr???ng';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: showPassword ? false : true,
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                      "M???t kh???u")
                                  .copyWith(
                            suffixIcon: showPassword
                                ? IconButton(
                                    icon: const Icon(Icons.visibility,
                                        color: appColor),
                                    onPressed: () => handleShowPassword(),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.visibility_off,
                                        color: appColor),
                                    onPressed: () => handleShowPassword(),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SendForgotCodeScreen(),
                                    settings: const RouteSettings(
                                        name: '/forgot-password'),
                                  ));
                                },
                                child: const Text(
                                  "Qu??n m???t kh???u?",
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,
                        Material(
                          color: appColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: _loading
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      authBloc.add(
                                        AuthLoggedEvent(
                                          Login(
                                              username: email,
                                              password: password),
                                        ),
                                      );
                                    }
                                  },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              child: _loading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    )
                                  : const Text(
                                      "????ng nh???p",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: "B???n ch??a c?? t??i kho???n?"
                                  .text
                                  .color(appColor)
                                  .make(),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                    settings: const RouteSettings(
                                      name: '/register',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: " ????ng k?? ngay."
                                    .text
                                    .bold
                                    .color(appColor)
                                    .textStyle(const TextStyle(
                                        fontWeight: FontWeight.bold))
                                    .make(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_buildImageHeader(BuildContext context) {
  return SizedBox(
    // color: appColor,
    child: Image.asset('assets/images/login.png',
        width: MediaQuery.of(context).size.width,
        errorBuilder: (context, error, stackTrace) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: const Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Loading',
            valueColor: AlwaysStoppedAnimation<Color>(Vx.black),
          ),
        ),
      );
    }, fit: BoxFit.cover),
  );
}
