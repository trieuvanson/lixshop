import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lixshop/responsive/mobile_screen_layout.dart';
import 'package:lixshop/responsive/responsive_layout_screen.dart';
import 'package:lixshop/responsive/web_screen_layout.dart';
import 'package:lixshop/screens/home_screen.dart';
import 'package:lixshop/screens/signup_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../contains/colors.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
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
      setState(() {
        changeButton = true;
      });
      print('email: $changeButton');
      if (email == "admin" && password == "admin123") {
        await Future.delayed(
          const Duration(seconds: 2),
        );
        await Navigator.of(context).pushReplacementNamed("/");
        setState(() {
          changeButton = false;
        });
      } else {
        setState(() {
          print("Wrong");
          changeButton = false;
        });
      }
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
    return Scaffold(
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
        child: SizedBox(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      // vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: appColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: "Email/Tên đăng nhập/Số điện thoại",
                            labelStyle: const TextStyle(
                              color: appColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: appColor,
                              ),
                            ),
                          ),
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
                          obscureText: showPassword? true: false,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: appColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: "Nhập mật khẩu",
                            labelStyle: const TextStyle(
                              color: appColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: appColor,
                              ),
                            ),
                            suffixIcon: showPassword
                                ? IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () => handleShowPassword(),
                            )
                                : IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () => handleShowPassword(),
                            ),
                          ),
                        ),
                        20.heightBox,
                        Material(
                          color: appColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () => handleLogin(context),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              child: changeButton
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
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
        // child: Container(
        //   // decoration: const BoxDecoration(
        //   //   image: DecorationImage(
        //   //     image: AssetImage("assets/images/login.png"),
        //   //     fit: BoxFit.fill,
        //   //   ),
        //   // ),
        //   // padding: const EdgeInsets.symmetric(horizontal: 32),
        //   width: double.infinity,
        //   child: SingleChildScrollView(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Image.asset("assets/images/login.png",
        //           fit: BoxFit.cover,
        //         ),
        //         32.heightBox,
        //         MyTextFieldInput(
        //             textEditingController: _emailController,
        //             hintText: "Enter your email",
        //             textInputType: TextInputType.emailAddress),
        //         24.heightBox,
        //         MyTextFieldInput(
        //             textEditingController: _emailController,
        //             hintText: "Enter your email",
        //             textInputType: TextInputType.emailAddress),
        //         24.heightBox,
        //         MyTextFieldInput(
        //             textEditingController: _emailController,
        //             hintText: "Enter your email",
        //             textInputType: TextInputType.emailAddress),
        //         24.heightBox,MyTextFieldInput(
        //             textEditingController: _emailController,
        //             hintText: "Enter your email",
        //             textInputType: TextInputType.emailAddress),
        //         24.heightBox,MyTextFieldInput(
        //             textEditingController: _emailController,
        //             hintText: "Enter your email",
        //             textInputType: TextInputType.emailAddress),
        //         24.heightBox,
        //
        //
        //
        //         MyTextFieldInput(
        //           textEditingController: _passwordController,
        //           hintText: "Enter your password",
        //           textInputType: TextInputType.text,
        //           isPassword: true,
        //         ),
        //         24.heightBox,
        //         InkWell(
        //           child: _loading
        //               ? const CircularProgressIndicator().centered()
        //               : Container(
        //                   child: "Login".text.make(),
        //                   width: double.infinity,
        //                   alignment: Alignment.center,
        //                   decoration: const ShapeDecoration(
        //                       shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(4),
        //                     ),
        //                   )),
        //                 ).p16().backgroundColor(Vx.gray100),
        //         ),
        //         // Flexible(child: Container(), flex: 1),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               child: "Don't have an account?".text.make(),
        //               padding: const EdgeInsets.symmetric(vertical: 8),
        //             ),
        //             GestureDetector(
        //               onTap: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) => LoginScreen()));
        //               },
        //               child: Container(
        //                 child: " Sign up."
        //                     .text
        //                     .textStyle(
        //                         const TextStyle(fontWeight: FontWeight.bold))
        //                     .make(),
        //                 padding: const EdgeInsets.symmetric(vertical: 8),
        //               ),
        //             ),
        //           ],
        //         )
        //         //email
        //         //password
        //         //login button
        //         //Transition to signup screen
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lixshop/responsive/mobile_screen_layout.dart';
import 'package:lixshop/responsive/responsive_layout_screen.dart';
import 'package:lixshop/responsive/web_screen_layout.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (email == "admin" && password == "admin123") {
        setState(() {
          changeButton = true;
        });
        await Future.delayed(
          const Duration(seconds: 1),
        );
        await Navigator.of(context).pushReplacementNamed(
          "/",
        );
        setState(() {
          changeButton = false;
        });
      } else {
        setState(() {
          print("Wrong");
          changeButton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(       // color: context.cardColor,
      backgroundColor: appColor ,
        appBar: AppBar(
          backgroundColor: appColor,
          shadowColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Vx.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Vx.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout()),
                ),
              );
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      child: Column(
                        children: [
                          Flexible(child: Container(), flex: 2),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your email",
                              labelText: "Email",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Enter your password",
                              labelText: "Password",
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            color: Colors.deepPurple,
                            borderRadius:
                                BorderRadius.circular(changeButton ? 50 : 8),
                            child: InkWell(
                              onTap: () => handleLogin(context),
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: changeButton ? 50 : 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: changeButton
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

*/
