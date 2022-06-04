import 'dart:convert';

import 'package:lixshop/utils/helpers/secure_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';
import 'dart:io';

class CartController {
  Future<CartModel> readCartFromFileJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    if (file.existsSync()) {
      final contents = await file.readAsString();
      var json = contents.trim().isNotEmpty
          ? jsonDecode(contents)
          : const CartModel(cart: []);
      CartModel cartModel =
          contents.isNotEmpty ? CartModel.fromJson(json) : json;
      return cartModel;
    }
    return const CartModel();
  }

  void saveCartToFileJson(List<Cart> cart) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    // print('Save to file: ${file.path}');
    final contents = jsonEncode(CartModel(cart: cart).toJson());
    await file.writeAsString(contents.toString());
  }

  //remove all cart
  void removeAllCart() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cart.json');
    print('Remove all cart: ${file.path}');
    await file.delete();
  }

  String? agentName(int idAgent) {
    dynamic agent;
    secureStorage
        .readKey("idAndNameDist")
        .then((value) => agent = jsonDecode(value));
    print('agent: $agent');
    return agent[idAgent];
  }
}

final cartController = CartController();
