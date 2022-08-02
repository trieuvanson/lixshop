import 'package:lixshop/utils/convert/vi_to_en/vietnamese_parser_engine.dart';

import '../../models/order/order.dart';

class OrderController {
  List<Order> filterByStatus(List<Order> orders, String status) {
    List<Order> filteredOrders = [];
    for (var order in orders) {
      if (status == "ALL") {
        return orders;
      }
      if (order.status == status) {
        filteredOrders.add(order);
      }

    }
    return filteredOrders;
  }

  List<Order> searchByOrderId(List<Order> orders, String keyword) {
    List<Order> filteredOrders = [];

    condition(final order) {
      if (vietnameseParserEngine
              .unsigned("Đơn hàng #${order.idDH}".toLowerCase())
              .contains(
                  vietnameseParserEngine.unsigned(keyword.toLowerCase())) ||
          vietnameseParserEngine
              .unsigned(order.agentLixName!.toLowerCase())
              .contains(
                  vietnameseParserEngine.unsigned(keyword.toLowerCase())) ||
          vietnameseParserEngine.unsigned(order.status!.toLowerCase()).contains(
              vietnameseParserEngine.unsigned(keyword.toLowerCase()))) {
        return true;
      }
      return false;
    }

    for (var order in orders) {
      // if (order.idDH.toString().contains(keyword) ||
      //     vietnameseParserEngine
      //         .unsigned(order.agentLixName!.toLowerCase())
      //         .contains(
      //             vietnameseParserEngine.unsigned(keyword.toLowerCase())) ||
      //     vietnameseParserEngine.unsigned(order.status!.toLowerCase()).contains(
      //         vietnameseParserEngine.unsigned(keyword.toLowerCase()))) {
      //   filteredOrders.add(order);
      // }

      if (condition(order)) {
        filteredOrders.add(order);
      }
    }
    return filteredOrders;
  }
}

final orderController = OrderController();
