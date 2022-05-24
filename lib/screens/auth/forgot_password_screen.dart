import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../../repositories/repositories.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String phoneNumber;

  const ForgotPasswordScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _loading = false;
  String password = "";
  String confirmPassword = "";
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  Timer? _timer;
  int _start = 120;
  bool _counting = false;
  String _otp = "";

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    //check regex Vn number phone
    _counting = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _start = 120;
            _counting = false;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  handleSendOTP() async {
    try {
      final res =
          await authRepository.sendForgotPasswordOTP(phone: widget.phoneNumber);
      if (res.err != -1) {
        setState(() {
          _counting = true;
        });
        _startTimer();
      } else {
        showSnackBar(res.msg!, context);
      }
    } catch (e) {
      showSnackBar("Có lỗi xảy ra vui lòng thử lại!", context);
    }
  }

  handleForgotPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        final res = await authRepository.checkForgotPasswordOTPAndResetPassword(
            phone: widget.phoneNumber, otp: _otp, password: password);
        if (res.err != -1) {
          showSnackBar(res.msg!, context);
          await Future.delayed(const Duration(seconds: 2), () {
            Get.offAll(() => const LoginScreen());
          });
        } else {
          showSnackBar(res.msg!, context);
        }
      } catch (e) {
        showSnackBar("Có lỗi xảy ra vui lòng thử lại!", context);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  handleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _timer?.cancel();
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
                            ],
                          ),
                        ),
                        10.heightBox,
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                      "Mã xác minh")
                                  .copyWith(
                            suffix: _counting
                                ? Text(
                                    "${_start}s",
                                    style: const TextStyle(
                                      color: Vx.blue400,
                                    ),
                                  )
                                : GestureDetector(
                                    child: const Text(
                                      "Gửi lại",
                                      style: TextStyle(
                                        color: Vx.blue400,
                                      ),
                                    ),
                                    onTap: () {
                                      handleSendOTP();
                                    }),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _otp = value;
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
                            if (!RegExp(
                                    "^(?=.*\\d)(?=.*[a-z])(?=.*[a-zA-Z]).{8,}\$")
                                .hasMatch(value!)) {
                              return "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ và số";
                            }
                            return null;
                          },
                          obscureText: showPassword ? true : false,
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                      "Mật khẩu mới")
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
                              confirmPassword = value;
                            });
                          },
                          validator: (value) {
                            if (!RegExp(
                                "^(?=.*\\d)(?=.*[a-z])(?=.*[a-zA-Z]).{8,}\$")
                                .hasMatch(value!)) {
                              return "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ và số";
                            } else if (value != password) {
                              return "Mật khẩu không khớp";
                            }
                            return null;
                          },
                          obscureText: showPassword ? true : false,
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                      "Nhập lại mật khẩu mới")
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
