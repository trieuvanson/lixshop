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
}

final orderController = OrderController();
