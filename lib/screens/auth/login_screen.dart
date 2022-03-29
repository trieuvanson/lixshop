import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/auth/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../contains/colors.dart';
import '../../responsive/responsive_screen.dart';
import '../../utils/helpers/error_message.dart';
import '../../utils/helpers/modal_loading.dart';
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
      // setState(() {
      //   _loading = true;
      // });
      // print('email: $_loading');
      // await Future.delayed(
      //   const Duration(seconds: 5),
      // );
      // if (email == "admin" && password == "admin123") {
      //   await Navigator.of(context).pushReplacementNamed("/");
      //   showSnackBar("content", context);
      // } else {
      //   showSnackBar("error", context);
      // }
      // setState(() {
      //   _loading = false;
      // });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      setState(() {});
      print("isLogin: ${prefs.getBool('isLogin')}");
      Get.to(
        () => const MobileScreenLayout(),
        routeName: "/register",
      );
      print('email: $_loading');
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
          modalLoading(context);
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else {
          Get.to(() => const MobileScreenLayout());
        }
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor,
          // shadowColor: Colors.transparent,
          elevation: 0,
          // iconTheme: const IconThemeData(color: Vx.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Vx.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MobileScreenLayout(),
                settings: const RouteSettings(name: '/'),
              ));
            },
          ),
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
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                  "Số điện thoại"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
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
                              return 'Không được để trống';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: showPassword ? false : true,
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                      "Mật khẩu")
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                    settings: const RouteSettings(
                                        name: '/forgot-password'),
                                  ));
                                },
                                child: const Text(
                                  "Quên mật khẩu?",
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 16,
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
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                authBloc.add(LoginEvent(Login(
                                    username: email, password: password)));
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              child: _loading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : const Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                        fontSize: 22,
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
                              child: "Bạn chưa có tài khoản?"
                                  .text
                                  .color(appColor)
                                  .make(),
                              padding: const EdgeInsets.symmetric(vertical: 8),
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
                                child: " Đăng ký ngay."
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
