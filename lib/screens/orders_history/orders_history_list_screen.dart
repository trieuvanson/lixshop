import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/controllers/order/order_controller.dart';
import 'package:lixshop/repositories/order/order_repository.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/order/order.dart';
import '../screen.dart';
import 'constants/order_status.dart';

class OrderHistoryListScreen extends StatefulWidget {
  final int tabIndex;

  const OrderHistoryListScreen({Key? key, required this.tabIndex})
      : super(key: key);

  @override
  State<OrderHistoryListScreen> createState() => _OrderHistoryListScreenState();
}

class _OrderHistoryListScreenState extends State<OrderHistoryListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: orderStatus.length, vsync: this);
    _tabController.index = widget.tabIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: orderStatus.length,
        child: Scaffold(
          appBar: _appBar(context),
          body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: orderStatus
                  .map(
                    (status) => Tab(
                        child: TabBarPage(
                            tabIndex: _tabController.index, status: status)),
                  )
                  .toList()),
        ));
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
        controller: _tabController,
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
        tabs: orderStatus
            .map(
              (status) => Tab(text: status),
            )
            .toList(),
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
}

class TabBarPage extends StatelessWidget {
  final String status;
  final int tabIndex;

  const TabBarPage({Key? key, required this.status, required this.tabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: orderRepository.getOrdersByUser(),
      builder: (context, AsyncSnapshot<List<Order>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Order> orders = orderController.filterByStatus(
            snapshot.data!, orderStatusMap[status]!);
        return orders.isNotEmpty
            ? ListView(
                children: List<Widget>.generate(
                  orders.length,
                  (index) => CheckoutItem(order: orders[index]),
                ),
              )
            : const Center(child: Text("Không có dữ liệu"));
      },
    );
  }
}

class CheckoutItem extends StatelessWidget {
  final Order order;

  const CheckoutItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            () => OrderHistoryItemDetailScreen(order: order),
            curve: Curves.easeInToLinear,
            transition: Transition.rightToLeft,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: "Đơn hàng #${order.idDH}".text.xl.bold.make(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: orderColorMap[order.status]!,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: orderColorMap[order.status]!
                                      .withOpacity(0.5),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: orderStatusMapReverse[order.status]!
                                    .text
                                    .size(10)
                                    .color(orderColorTextMap[order.status]!)
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
                  "Thời gian ${order.dateDH}".text.gray500.make(),
                  "${order.tongtienDH}đ"
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
                      for (var i in order.donHangDetailDTO2s!)
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                i.productImage!,
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
