import 'package:flutter/foundation.dart';

import '../database/db_helper.dart';
import '../database/db_model.dart';

class CartProvider extends ChangeNotifier {
  DatabaseHelper? databaseHelper;
  Future<List<Carts>>? cartsList;
  double totalPrice = 0;
  int deliveryTime = 0;
  int len = 0;
  bool isEmpty = true;

  CartProvider() {
    databaseHelper = DatabaseHelper();
    loadData();
  }

  loadHomePage() async{
    cartsList = databaseHelper!.getCarts();
    List<Carts> carts = await cartsList!;
    len = carts.length;
    notifyListeners();

  }

  loadData() async {
    cartsList = databaseHelper!.getCarts();
    List<Carts> carts = await cartsList!;
    isEmpty = carts.isEmpty;

    double newTotalPrice = 0;
    deliveryTime = carts.length * 15;
    for (var order in carts) {
      newTotalPrice += order.price * order.quantity;
    }
    totalPrice = newTotalPrice;
    len = carts.length;
    notifyListeners();
  }

  void decrementQuantity(Carts order) {
    if (order.quantity > 1) {
      order.quantity -= 1;
      databaseHelper!.update(order);
      loadData();
      // notifyListeners();
    }
  }

  void incrementQuantity(Carts order) {
    order.quantity += 1;
    if (kDebugMode) {
      print(totalPrice.toString());
    }
    databaseHelper!.update(order);
    loadData();
  }

  void deleteOrder(int id) {
    databaseHelper!.delete(id);
    loadData();
  }
}
