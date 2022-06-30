import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/repositories/repositories.dart';
import 'package:lixshop/screens/auth/forgot_password_screen.dart';
import 'package:lixshop/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../../widgets/widgets.dart';

class SendForgotCodeScreen extends StatefulWidget {
  const SendForgotCodeScreen({Key? key}) : super(key: key);

  @override
  State<SendForgotCodeScreen> createState() => _SendForgotCodeScreenState();
}

class _SendForgotCodeScreenState extends State<SendForgotCodeScreen> {
  String phoneNumber = "";
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  Future<void> handleSubmit() async {
    bool checkPhone = RegExp(
            r'^(0)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$')
        .hasMatch(phoneNumber);
    if (checkPhone) {
      try {
        setState(() {
          _loading = true;
        });
        final res = await authRepository.sendForgotPasswordOTP(phone: phoneNumber);
        if (res.err != -1) {
          Get.to(() => ForgotPasswordScreen(phoneNumber: phoneNumber));
        } else {
          showSnackBar(res.msg!, context);
        }
      } catch (e) {
        showSnackBar("Có lỗi xảy ra vui lòng thử lại!", context);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    } else {
      showSnackBar("Vui lòng nhập đúng định dạng số điện thoại", context);
    }
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
                              "Quên mật khẩu"
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
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                  "Số điện thoại"),
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                        20.heightBox,
                        Material(
                          color: appColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: _loading ? () {} : () => {handleSubmit()},
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
                                      "Gửi mã",
                                      style: TextStyle(
                                        fontSize: 18,
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
