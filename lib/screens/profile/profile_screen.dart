import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/garniture/garniture_screen.dart';
import 'package:lixshop/screens/order_history/order_history_list_screen.dart';
import 'package:lixshop/screens/profile/profile_information_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  AnimationController? animationController;
  Animation<double>? animation;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignCourseAppTheme.nearlyWhite,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            delegate: SliverHeaderBar(expandedHeight:170),
            pinned: false,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: DesignCourseAppTheme.notWhite,
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
                                  () => const OrderHistoryListScreen(),
                                  transition: Transition.rightToLeftWithFade,
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
                              children: const [
                                _HistoryItem(
                                    title: "Chờ xác nhận",
                                    icon: Icons.check_circle_outline),
                                _HistoryItem(
                                    title: "Đã xác nhận",
                                    icon: Icons.check_circle_outline),
                                _HistoryItem(
                                    title: "Đang giao hàng",
                                    icon: Icons.check_circle_outline),
                                _HistoryItem(
                                    title: "Đang giao hàng",
                                    icon: Icons.check_circle_outline),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
                            _MenuItem(
                              icon: Icons.add_to_home_screen,
                              title: "Trưng bày",
                              onTap: () {
                                Get.to(() => const GarnitureScreen(),
                                    transition: Transition.leftToRight);
                              },
                            ),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Săn thưởng"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Thông tin xuất hoá đơn"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Địa chỉ"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Quản lý tài khoản liên kết"),
                            const _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Quản lý bán hàng POS"),
                          ],
                        ),
                      ),
                    ),
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
                          children: const [
                            _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Cài đặt"),
                            _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Điều khoản và chính sách"),
                            _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Gửi phản hồi"),
                            _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Câu hỏi thường gặp"),
                            _MenuItem(
                                icon: Icons.add_to_home_screen,
                                title: "Liên hệ"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
    );
  }
}

class SliverHeaderBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  SliverHeaderBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          clipBehavior: Clip.antiAlias,
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
              child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                                () => const ProfileInformationScreen(),
                            curve: Curves.easeInToLinear,
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 50,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                      ),
                                    ),
                                  ),
                                  16.widthBox,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 200,
                                        child: Text(
                                          "Cửa hàng ABC Cửa hàng ABC Cửa hang ABC cua",
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      4.heightBox,
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Vx.green500,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            "Thứ hạng",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_cart,
                              color: Colors.white),
                        ),
                      ),
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
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: SizedBox(
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
