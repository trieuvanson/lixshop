

import 'package:flutter/material.dart';
import 'package:lixshop/models/city/city_model.dart';
import 'package:lixshop/repositories/app_repository.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../contains/colors.dart';
import '../../responsive/responsive_screen.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String email = "";
  String password = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  var _currentSelectedValue;

  handleRegister(BuildContext context) async {
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

  final _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];

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
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                  "Tên cửa hàng"),
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
                        // TextFormField(
                        //   decoration:
                        //       TextFormFieldCommonStyle.textFormFieldStyle(
                        //           "Họ và tên chủ cửa hàng"),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Không được để trống';
                        //     }
                        //     return null;
                        //   },
                        //   onChanged: (value) {
                        //     setState(() {
                        //       email = value;
                        //     });
                        //   },
                        // ),
                        FutureBuilder<CityModel>(
                          future: AppRepository().getCity(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.error != null &&
                                  snapshot.data!.error!.isNotEmpty) {
                                return _buildErrorWidget(snapshot.data!.error);
                              }
                              return Column(
                                children: [
                                  FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration:
                                        TextFormFieldCommonStyle.textFormFieldStyle(
                                            "Thành phố/tỉnh"),
                                        isEmpty: _currentSelectedValue == '',
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _currentSelectedValue,
                                            isDense: true,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _currentSelectedValue = newValue;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items: _currencies.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  15.heightBox,
                                  FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration:
                                        TextFormFieldCommonStyle.textFormFieldStyle(
                                            "Quận/huyện"),
                                        isEmpty: _currentSelectedValue == '',
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _currentSelectedValue,
                                            isDense: true,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _currentSelectedValue = newValue;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items: _currencies.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  15.heightBox,
                                  FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration:
                                        TextFormFieldCommonStyle.textFormFieldStyle(
                                            "Phường/xã"),
                                        isEmpty: _currentSelectedValue == '',
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _currentSelectedValue,
                                            isDense: true,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _currentSelectedValue = newValue;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items: _currencies.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  15.heightBox,
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget(snapshot.error);
                            } else {
                              return _buildLoadingWidget();
                            }
                          },
                        ),

                        TextFormField(
                          decoration:
                              TextFormFieldCommonStyle.textFormFieldStyle(
                                  "Số nhà, tên đường,..."),
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
                        35.heightBox,
                        Material(
                          color: appColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () => handleRegister(context),
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
                                      "Đăng ký",
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
                              child: "Bạn đã có tài khoản?"
                                  .text
                                  .color(appColor)
                                  .make(),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen()));
                              },
                              child: Container(
                                child: " Đăng nhập ngay."
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
Widget _buildLoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ),
  );
}

//display error
Widget _buildErrorWidget(dynamic error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          'Something is wrong',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}

_buildImageHeader(BuildContext context) {
  return SizedBox(
    // color: appColor,
    child: Image.asset('assets/images/register.png',
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
