import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/repositories/app_repository.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../../core/core.dart';
import '../../screen_layout.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _loading = false;
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  Register register = Register();
  int selectedCity = 0;
  int selectDistrict = 0;
  int selectWard = 0;

  List<DropdownMenuItem<int>> districtsDropdown = [];
  List<DropdownMenuItem<int>> wardsDropdown = [];
  bool isError = false;

  List<City>? cities;

  @override
  initState() {
    getCities();
    super.initState();
  }

  handleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  onRegister(final userBloc) {
    if (_formKey.currentState!.validate()) {
      if (isError) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text("Không thể kết nối tới máy chủ"),
              actions: <Widget>[
                FlatButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        userBloc.add(UserEventRegister(register: register));
      }
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  getCities() async {
    _loading = true;
    try {
      final res = await appRepository.getCityHttp();
      isError = res.error != null;
      setState(() {
        cities = res.cities;
      });
      print('cities:');
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
    }
  }

  void selectedCityDropdown(List<City> listCity, int value) {
    districtsDropdown = [];
    final districts = appRepository.getDistrictsByCity(listCity, value);
    for (var item in districts.districts!) {
      districtsDropdown.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item.id,
      ));
    }
    selectDistrict = 0;
    selectedCity = value;
    setState(() {});
  }

  void selectedDistrictDropdown(List<City> cities, int value) {
    wardsDropdown = [];
    final districts = appRepository.getDistrictsByCity(cities, selectedCity);
    final wards = appRepository.getWardsByDistrict(districts.districts!, value);

    for (var item in wards.wards!) {
      wardsDropdown.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item.id,
      ));
    }
    selectWard = 0;
    selectDistrict = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          setState(() {
            _loading = true;
          });
        }
        if (state is UserErrorState) {
          setState(() {
            _loading = false;
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Thông báo'),
                content: Text(state.error),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        if (state is UserSuccessState) {
          _loading = false;
          _formKey.currentState!.reset();
          selectedCity = 0;
          selectDistrict = 0;
          selectWard = 0;
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Thông báo'),
                content: Text(state.message),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                  ),
                ],
              );
            },
          );
          setState(() {});
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
              Get.back();
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
                    _loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Vx.green500),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: TextFormFieldCommonStyle
                                      .textFormFieldStyle("Số điện thoại"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Không được để trống';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      register.phone = value;
                                    });
                                  },
                                ),
                                15.heightBox,
                                TextFormField(
                                  decoration: TextFormFieldCommonStyle
                                      .textFormFieldStyle("Tên hiển thị"),
                                  onChanged: (value) {
                                    setState(() {
                                      register.shopName = value;
                                    });
                                  },
                                ),
                                15.heightBox,
                                Column(
                                  children: [
                                    FormField<int>(
                                      builder: (FormFieldState<int> state) {
                                        return InputDecorator(
                                          decoration: TextFormFieldCommonStyle
                                              .textFormFieldStyle(
                                                  "Tỉnh/thành phố"),
                                          isEmpty: selectedCity == 0,
                                          // isEmpty: true,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              value: selectedCity > 0
                                                  ? selectedCity
                                                  : null,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                selectedCityDropdown(
                                                    cities!, newValue!);
                                                register.city = newValue;
                                                setState(() {});
                                              },
                                              items: cities!.map((City city) {
                                                return DropdownMenuItem<int>(
                                                  value: city.id!,
                                                  child: Text(city.name!),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    15.heightBox,
                                    FormField<int>(
                                      builder: (FormFieldState<int> state) {
                                        return InputDecorator(
                                          decoration: TextFormFieldCommonStyle
                                              .textFormFieldStyle("Quận/huyện"),
                                          isEmpty: selectDistrict == 0,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              value: selectDistrict > 0
                                                  ? selectDistrict
                                                  : null,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                selectedDistrictDropdown(
                                                    cities!, newValue!);
                                                register.district = newValue;
                                                setState(() {});
                                              },
                                              items:
                                                  districtsDropdown.isNotEmpty
                                                      ? districtsDropdown
                                                      : const [],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    15.heightBox,
                                    FormField<int>(
                                      builder: (FormFieldState<int> state) {
                                        return InputDecorator(
                                          decoration: TextFormFieldCommonStyle
                                              .textFormFieldStyle("Phường/Xã"),
                                          isEmpty: selectWard == 0,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              value: selectWard > 0
                                                  ? selectWard
                                                  : null,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectWard = newValue!;
                                                  register.ward = newValue;
                                                });
                                              },
                                              items: wardsDropdown.isNotEmpty
                                                  ? wardsDropdown
                                                  : const [],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    15.heightBox,
                                  ],
                                ),
                                TextFormField(
                                  decoration: TextFormFieldCommonStyle
                                      .textFormFieldStyle(
                                          "Số nhà, tên đường,..."),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Không được để trống';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      register.address = value;
                                    });
                                    print(register.address);
                                  },
                                ),
                                35.heightBox,
                                Material(
                                  color: appColor,
                                  borderRadius: BorderRadius.circular(8),
                                  child: InkWell(
                                    onTap: () => onRegister(userBloc),
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
                                              "Đăng ký",
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
                                      child: "Bạn đã có tài khoản?"
                                          .text
                                          .color(appColor)
                                          .make(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: Container(
                                        child: " Đăng nhập ngay."
                                            .text
                                            .bold
                                            .color(appColor)
                                            .textStyle(const TextStyle(
                                                fontWeight: FontWeight.bold))
                                            .make(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
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
  return Container();
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
