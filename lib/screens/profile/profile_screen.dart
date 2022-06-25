import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/repositories/repositories.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/core.dart';
import '../../utils/design_course_app_theme.dart';
import '../screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  AuthUser? _authUser;

  @override
  initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    _authUser = await secureStorage.getCurrentUser();
    _authUser ??= const AuthUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final bottomNavigationCubit = BlocProvider.of<NavigationCubit>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LogoutAuthState) {
          bottomNavigationCubit.changeNavigation(0);
          BlocProvider.of<CartBloc>(context).add(RemoveAllCart());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: DesignCourseAppTheme.notWhite,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: SliverHeaderBar(
                  expandedHeight: 200, user: _authUser ?? const AuthUser()),
              pinned: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () =>
                                      const OrderHistoryListScreen(tabIndex: 0),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child:
                                        "Lịch sử nhập hàng".text.xl.bold.make(),
                                  ),
                                  Row(
                                    children: [
                                      "Xem tất cả"
                                          .text
                                          .size(16)
                                          .green500
                                          .make(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Vx.green700,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            10.heightBox,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _HistoryItem(
                                    onTap: () => Get.to(
                                          () => const OrderHistoryListScreen(
                                              tabIndex: 1),
                                        ),
                                    title: "Chờ xác nhận",
                                    icon: Icons.check_circle_outline),
                                _HistoryItem(
                                    onTap: () => Get.to(
                                          () => const OrderHistoryListScreen(
                                              tabIndex: 2),
                                        ),
                                    title: "Đang giao hàng",
                                    icon: Icons.check_circle_outline),
                                _HistoryItem(
                                    onTap: () => Get.to(
                                          () => const OrderHistoryListScreen(
                                              tabIndex: 3),
                                        ),
                                    title: "Hoàn tất",
                                    icon: Icons.check_circle_outline),
                                _HistoryItem(
                                    onTap: () => Get.to(
                                          () => const OrderHistoryListScreen(
                                              tabIndex: 4),
                                        ),
                                    title: "Đã huỷ",
                                    icon: Icons.check_circle_outline),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 16.heightBox,
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: DesignCourseAppTheme.nearlyWhite,
                    //     borderRadius: const BorderRadius.all(
                    //       Radius.circular(16.0),
                    //     ),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //           color:
                    //               DesignCourseAppTheme.grey.withOpacity(0.2),
                    //           offset: const Offset(1.1, 1.1),
                    //           blurRadius: 8.0),
                    //     ],
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         _MenuItem(
                    //           icon: Icons.add_to_home_screen,
                    //           title: "Trưng bày",
                    //           onTap: () {
                    //             Get.to(() => const GarnitureScreen());
                    //           },
                    //         ),
                    //         const _MenuItem(
                    //             icon: Icons.add_to_home_screen,
                    //             title: "Săn thưởng"),
                    //         const _MenuItem(
                    //             icon: Icons.add_to_home_screen,
                    //             title: "Thông tin xuất hoá đơn"),
                    //         const _MenuItem(
                    //             icon: Icons.add_to_home_screen,
                    //             title: "Địa chỉ"),
                    //         const _MenuItem(
                    //             icon: Icons.add_to_home_screen,
                    //             title: "Quản lý tài khoản liên kết"),
                    //         const _MenuItem(
                    //             icon: Icons.add_to_home_screen,
                    //             title: "Quản lý bán hàng POS"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    16.heightBox,
                    Container(
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const _MenuItem(
                            //     icon: Icons.add_to_home_screen,
                            //     title: "Cài đặt"),
                            _MenuItem(
                              icon: Icons.add_to_home_screen,
                              title: "Trưng bày",
                              onTap: () {
                                // Get.to(() => const GarnitureScreen());
                              },
                            ),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Điều khoản và chính sách"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Gửi phản hồi"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Câu hỏi thường gặp"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Liên hệ"),
                            _MenuItem(
                                onTap: () {
                                  authBloc.add(AuthLogoutEvent());
                                },
                                icon: Icons.logout,
                                title: "Đăng xuất"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (_, index) => ListTile(
            //       title: Text("Index: $index"),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class SliverHeaderBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final AuthUser user;

  SliverHeaderBar({required this.expandedHeight, required this.user});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD7124A),
                    Color(0x7C00A505),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => const CartScreen());
                          },
                          icon: const Icon(Icons.shopping_cart,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const ProfileInformationScreen(),
                        curve: Curves.easeInToLinear,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  child: Image.asset(
                                    "assets/images/avatar-den-co-don-9.webp",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              16.widthBox,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      user.name ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   top: expandedHeight / 2 - shrinkOffset,
            //   left: MediaQuery.of(context).size.width / 4,
            //   child: Opacity(
            //     opacity: (1 - shrinkOffset / expandedHeight),
            //     child: Card(
            //       elevation: 10,
            //       child: SizedBox(
            //         height: expandedHeight,
            //         width: MediaQuery.of(context).size.width / 2,
            //         child: const FlutterLogo(),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _HistoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback? onTap;

  const _HistoryItem({required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: size.width/5,
          color: Colors.white,
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: size.width * 20/100,
                  child: Icon(
                    icon,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: size.width/5,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap ?? () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: Vx.gray500,
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Vx.gray500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? subTitle;
  final GestureTapCallback? onTap;

  const _MenuItem(
      {Key? key,
      required this.icon,
      required this.title,
      this.subTitle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      icon,
                      size: 24,
                    ),
                  ),
                  title.text.size(16).gray700.make(),
                ],
              ),
              Row(
                children: [
                  subTitle ?? const SizedBox.shrink(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Vx.gray500,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
