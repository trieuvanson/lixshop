import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../../core/core.dart';
import '../../models/models.dart';
import '../../utils/helpers/secure_storage.dart';
import '../../widgets/widgets.dart';
import '../auth/login_screen.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthUser? _currentUser;
  String? confirmDelete;
  bool hideConfirmDelete = true;
  late final _userBloc;

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    getUser();
    super.initState();
  }

  getUser() async {
    _currentUser = await secureStorage.getCurrentUser();
    setState(() {});
    print('');
  }

  deleteUser() async {
    try {
      _userBloc.add(UserEventDisable(password: confirmDelete!));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 300),
      length: 2,
      child: Scaffold(
        appBar: _appBar(context),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            buildProfileInformation(context),
            const Center(
              child: Text(
                'Chức năng đang được phát triển',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // buildProfileChangePassword(context),
            // const _CheckoutItem(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            labelColor: Vx.green500,
            unselectedLabelColor: Vx.gray500,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: Vx.green500,
              ),
            ),
            tabs: [
              Tab(text: "Tài khoản"),
              Tab(text: "Thông tin xuất hoá đơn"),
              // Tab(text: "Đổi mật khẩu"),
            ],
          ),
        ),
      ),
      title: "Thông tin cá nhân".text.black.make(),
      actions: [
        //delete
        BlocListener<UserBloc, UserState>(
          listener: (context, state) async {
            if(state is UserSuccessState) {
              showSnackBar(state.message, context, duration: 2000, color: Vx.green500);
              Navigator.pop(context);
              await Future.delayed(const Duration(milliseconds: 2000));
              Get.offAll(() => const LoginScreen());
            }
            if(state is UserErrorState) {
              showSnackBar(state.error, context, duration: 2000, color: Vx.red500);
              Navigator.pop(context);
            }
          },
          child: IconButton(
            icon: const Icon(Icons.delete, color: Vx.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      elevation: 0,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Xác nhận xoá vĩnh viễn tài khoản?"),
                          Text(
                            "* Xoá tài khoản sẽ làm mất tất cả dữ liệu của bạn",
                            style: TextStyle(
                              color: Vx.gray800,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "* Vui lòng nhập mật khẩu để xoá tài khoản!",
                            style: TextStyle(
                              color: Vx.gray800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      titleTextStyle: const TextStyle(
                        color: Vx.red500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      content: SizedBox(
                        child: TextFormField(
                          obscureText: hideConfirmDelete ? true : false,
                          maxLines: 1,
                          onChanged: (value) {
                            confirmDelete = value;
                            setState(() {
                            });
                          },
                          //suffixIcon
                          decoration: InputDecoration(
                            //secure = true
                            suffixIcon: IconButton(
                              icon: Icon(hideConfirmDelete
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  hideConfirmDelete = !hideConfirmDelete;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        FlatButton(
                          child: const Text("Hủy"),
                          onPressed: () {
                            setState(() {
                              confirmDelete = null;
                              hideConfirmDelete = true;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: const Text("Xác nhận"),
                          onPressed: () => {
                            deleteUser(),
                            setState(() {
                              confirmDelete = null;
                              hideConfirmDelete = true;
                            }),
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            },
            //tooltip
            tooltip: "Xoá vĩnh viễn tài khoản",
          ),
        ),
      ],
      titleSpacing: 0.0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildProfileInformation(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                            "Tên cửa hàng"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _currentUser?.name,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      15.heightBox,
                      // TextFormField(
                      //   decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                      //       "Họ và tên chủ cửa hàng"),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Không được để trống';
                      //     }
                      //     return null;
                      //   },
                      //   onChanged: (value) {
                      //     setState(() {});
                      //   },
                      // ),
                      // 15.heightBox,
                      TextFormField(
                        decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                            "Địa chỉ"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: TextEditingController(
                          text: _currentUser?.address,
                        ),
                      ),
                      15.heightBox,
                      TextFormField(
                        decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                            "Số điện thoại"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: TextEditingController(
                          text: _currentUser?.phone,
                        ),
                      ),
                      15.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Hình ảnh cửa hàng"
                              .text
                              .size(16)
                              .color(appColor)
                              .make(),
                          16.heightBox,
                          SizedBox(
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const ImageItem(
                                    image: "", title: "Hình ảnh bên ngoài"),
                                20.widthBox,
                                const ImageItem(
                                    image: "", title: "Hình ảnh bên trong"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      //
                      // TextFormField(
                      //   decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                      //       "Email"),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Không được để trống';
                      //     }
                      //     return null;
                      //   },
                      //   onChanged: (value) {
                      //     setState(() {});
                      //   },
                      // ),
                      35.heightBox,
                      Material(
                        color: appColor,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {
                            showSnackBar(
                              "Chức năng đang được phát triển",
                              context,
                              duration: 2000,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              "Cập nhật",
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
        );
      }),
    );
  }

  Widget buildProfileChangePassword(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 32),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                            "Mật khẩu cũ"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _currentUser?.name,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      15.heightBox,
                      TextFormField(
                        decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                            "Mật khẩu mới"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _currentUser?.name,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      15.heightBox,
                      TextFormField(
                        decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                            "Nhập lại mật khẩu mới"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _currentUser?.name,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      15.heightBox,
                      const Divider(),
                      //
                      // TextFormField(
                      //   decoration: TextFormFieldCommonStyle.textFormFieldStyle(
                      //       "Email"),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Không được để trống';
                      //     }
                      //     return null;
                      //   },
                      //   onChanged: (value) {
                      //     setState(() {});
                      //   },
                      // ),
                      35.heightBox,
                      Material(
                        color: appColor,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              "Cập nhật",
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
        );
      }),
    );
  }
}

// class _CheckoutItem extends StatelessWidget {
//   const _CheckoutItem({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: const BorderRadius.all(
//         Radius.circular(16.0),
//       ),
//       child: InkWell(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     child: "Đơn hàng #12412312".text.xl.bold.make(),
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Vx.green200,
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(8.0),
//                             ),
//                             boxShadow: <BoxShadow>[
//                               BoxShadow(
//                                   color: Vx.green50.withOpacity(0.5),
//                                   offset: const Offset(1.1, 1.1),
//                                   blurRadius: 8.0),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                                 child: "Đang chờ xác nhận"
//                                     .text
//                                     .green500
//                                     .bold
//                                     .make()),
//                           ),
//                         ),
//                       ),
//                       const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Vx.green700,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               5.heightBox,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   "Đặt vào ngày 20/10/2020".text.gray500.make(),
//                   "9,999,999đ"
//                       .text
//                       .color(Vx.red700.withOpacity(0.8))
//                       .bold
//                       .xl
//                       .make(),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       for (var i = 0; i < 5; i++)
//                         SizedBox(
//                           width: 100,
//                           height: 130,
//                           child: Center(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Image.network(
//                                 "https://picsum.photos/200",
//                                 height: 80,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//               const Divider(
//                 color: Vx.gray500,
//                 height: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ImageItem extends StatelessWidget {
  final String image;
  final String title;

  const ImageItem({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.fill,
              onError: (a, e) {},
            ),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Positioned(
        //   top: 5,
        //   right: 5,
        //   child: Icon(
        //     Icons.add_a_photo,
        //     color: Colors.black.withOpacity(0.5),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            height: 30,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
