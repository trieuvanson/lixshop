import 'dart:convert';

import 'package:lixshop/utils/helpers/secure_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/models.dart';
import 'dart:io';

class CartController {
  Future<CartModel> readCartFromFileJson() async {
    try {
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
    } catch (e) {
      print('Error: $e');
    }
    return const CartModel();
  }

  removeElementCart(Cart cart, CartModel cartModel) async {
    try {
      cartModel.cart.removeWhere((element) =>
          element.brandId == cart.brandId &&
          element.productDetail!.code == cart.productDetail!.code &&
          element.unit == cart.unit &&
          element.typeformVoucherCustom == cart.typeformVoucherCustom &&
          element.typeformVoucher == cart.typeformVoucher);
      saveCartToFileJson(cartModel.cart);
    } catch (e) {
      print('Error: $e');
    }
  }

  saveCartToFileJson(List<Cart> cart) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cart.json');
      // print('Save to file: ${file.path}');
      final contents = jsonEncode(CartModel(cart: cart).toJson());
      await file.writeAsString(contents.toString());
    } catch (e) {
      print('Error: $e');
    }
  }

  //remove all cart
  removeAllCart() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cart.json');
      print('Remove all cart: ${file.path}');
      await file.delete();
    } catch (e) {
      print('Error: $e');
    }
  }

  //extension ...

  List<Cart> checkBeforeAdd(List<Cart> carts, Cart current) {
    // print(current);
    List<Cart> currentCartList = carts.isNotEmpty ? carts : [];
    bool check = true;

    for (var item in carts) {
      if (item.typeformVoucherCustom == current.typeformVoucherCustom &&
          item.typeformVoucher == current.typeformVoucher &&
          item.productDetail!.code!.contains(current.productDetail!.code!) &&
          item.unit!.contains(current.unit!)) {
        check = false;
        item.quantity = item.quantity! + current.quantity!;
        break;
      }
    }

    if (check) {
      currentCartList.add(current);
    }
    print('currentCartList:${currentCartList.length}');

    return currentCartList;
  }

  List<Cart> checkBeforeUpdate(List<Cart> carts, Cart current) {
    // print(current);
    List<Cart> currentCartList = carts.isNotEmpty ? carts : [];
    bool check = false;

    for (var item in carts) {
      if (item.typeformVoucherCustom == current.typeformVoucherCustom &&
          item.typeformVoucher == current.typeformVoucher &&
          item.productDetail!.code!.contains(current.productDetail!.code!) &&
          item.unit!.contains(current.unit!)) {
        check = true;
        item.quantity = current.quantity!;
        break;
      }
    }
    print('check: $check');

    if (!check) {
      currentCartList.add(current);
    }
    return currentCartList;
  }

  agentName(int idAgent) async {
    var agent = await secureStorage.readKey("idAndNameDist");
    if (agent != null) {
      var agentList = jsonDecode(agent);
      for (var item in agentList) {
        if (item[idAgent.toString()] != null) {
          return item[idAgent.toString()];
        }
      }
    }
  }
}

final cartController = CartController();
