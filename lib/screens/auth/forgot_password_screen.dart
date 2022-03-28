
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../contains/colors.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String email = "";
  String password = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  handleForgotPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      print('email: $_loading');
      await Future.delayed(
        const Duration(seconds: 5),
      );
      if (email == "admin" && password == "admin123") {
        await Navigator.of(context).pushReplacementNamed("/");
        showSnackBar("content", context);
      } else {
        showSnackBar("error", context);
      }
      setState(() {
        _loading = false;
      });
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
            Navigator.of(context).pop();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Đặt lại mật khẩu"
                                  .text
                                  .bold
                                  .color(Vx.black)
                                  .xl4
                                  .make(),
                              "Mã xác nhận đã được gửi đến số điện thoại"
                                  .text
                                  .color(Vx.black)
                                  .xl
                                  .make(),
                            ],
                          ),
                        ),
                        10.heightBox,
                        TextFormField(
                          decoration:
                          TextFormFieldCommonStyle.textFormFieldStyle(
                            "Mã xác nhận",
                          ).copyWith(
                            suffix: "Gửi mã xác minh".text.color(Vx.blue400).make(),
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
                          obscureText: showPassword ? true : false,
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
                          obscureText: showPassword ? true : false,
                          decoration:
                          TextFormFieldCommonStyle.textFormFieldStyle(
                              "Nhập lại mật khẩu")
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
                        20.heightBox,
                        Material(
                          color: appColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () => handleForgotPassword(context),
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
                                "Hoàn thành",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
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
    child: Image.asset('assets/images/ForgotPassword.png',
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
