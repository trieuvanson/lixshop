import 'package:dio/dio.dart';
import 'package:lixshop/models/order/order.dart';

import '../../constants/env.dart';
import '../../utils/helpers/secure_storage.dart';

class OrderRepository {
  final String orderUrl = '$baseUrl/api/data/donhang/info';
  static final _dio = Dio();

  Future<List<Order>?> getOrdersByUser() async {
    try {
      var authorization = await secureStorage.readToken();
      final Response response = await _dio.get(orderUrl,
          options: Options(headers: {
            "Authorization": "Bearer ${authorization!.accessToken}",
          }));
      if (response.data['err'] == -1) {
        throw Exception(response.data['msg']);
      }
      List<Order> orders = response.data['dt'].map<Order>((json) {
        return Order.fromJson(json);
      }).toList();
      return orders;
    } on DioError catch (e) {
      print('getOrdersByUser error: $e');
      if (e.response?.statusCode == 401) {
        print('Token expired');
      } else if (e.response?.statusCode == 404) {
        print('ahihi');
      }
      throw Exception(e.response?.data['msg']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

final orderRepository = OrderRepository();
