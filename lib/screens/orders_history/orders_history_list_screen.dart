import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screen.dart';
import 'constants/order_status.dart';

class OrderHistoryListScreen extends StatelessWidget {
  const OrderHistoryListScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: orderStatus.length,
      child: Scaffold(
        appBar: _appBar(context),
        body: TabBarView(
          children: List<Widget>.generate(orderStatus.length, (i)
          => Tab(
              child: Text(orderStatus[i], style: GoogleFonts.getFont('Roboto', fontSize: 17))
          )
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context) {
  return AppBar(
    actions: [
      IconButton(
        icon: const Icon(Icons.search, color: Vx.black),
        onPressed: () {
          // showSearch(context: context, delegate: OrderHistorySearchDelegate());
        },
      ),
    ],
    bottom: TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      labelColor: Vx.green500,
      unselectedLabelColor: Vx.gray500,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3,
          color: Vx.green500,
        ),
      ),
      tabs: orderStatus.map((e) => Tab(text: e)).toList(),
    ),
    title: "Danh sách đơn hàng".text.black.make(),
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

class _CheckoutItem extends StatelessWidget {
  const _CheckoutItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            () => const OrderHistoryItemDetailScreen(),
            curve: Curves.easeInToLinear,
            transition: Transition.rightToLeft,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: "Đơn hàng #12412312".text.xl.bold.make(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Vx.green200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Vx.green50.withOpacity(0.5),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: "Đang chờ xác nhận"
                                    .text
                                    .green500
                                    .bold
                                    .make()),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Vx.green700,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Đặt vào ngày 20/10/2020".text.gray500.make(),
                  "9,999,999đ"
                      .text
                      .color(Vx.red700.withOpacity(0.8))
                      .bold
                      .xl
                      .make(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var i = 0; i < 5; i++)
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                "https://picsum.photos/200",
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Vx.gray500,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
