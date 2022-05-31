import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';
import 'dart:io';

class CartController {
  Future<CartModel> readCartFromFileJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    if (file.existsSync()) {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      CartModel cartModel = CartModel.fromJson(json);
      return cartModel;
    }
    return const CartModel();
  }

  void saveCartToFileJson(List<Cart> cart) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    print('Save to file: ${file.path}');
    final contents = jsonEncode(CartModel(cart: cart).toJson());
    await file.writeAsString(contents.toString());
  }

}
final cartController = CartController();