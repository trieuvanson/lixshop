import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../../widgets/widgets.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final _formKey = GlobalKey<FormState>();

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
            Container()
            // const _CheckoutItem(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      bottom: const TabBar(
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
        ],
      ),
      title: "Thông tin cá nhân".text.black.make(),
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
      child: FutureBuilder(
          builder: (context, snapshot) {
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
                              setState(() {});
                            },
                          ),
                          15.heightBox,
                          TextFormField(
                            decoration:
                                TextFormFieldCommonStyle.textFormFieldStyle(
                                    "Họ và tên chủ cửa hàng"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          15.heightBox,
                          TextFormField(
                            decoration:
                                TextFormFieldCommonStyle.textFormFieldStyle(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const ImageItem(
                                        image:
                                            "",
                                        title: "Hình ảnh bên ngoài"),
                                    20.widthBox,
                                    const ImageItem(
                                        image:
                                            "",
                                        title: "Hình ảnh bên trong"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
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
                              setState(() {});
                            },
                          ),
                          15.heightBox,
                          TextFormField(
                            decoration:
                                TextFormFieldCommonStyle.textFormFieldStyle(
                                    "Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          15.heightBox,
                          20.heightBox,
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
              onError: (a,e) {
              },
            ),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
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
