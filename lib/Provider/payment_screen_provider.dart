import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Utils/alert_dialog.dart';
import '../ViewModel/stripe_payment.dart';

class PaymentProvider extends ChangeNotifier {
  late DatabaseHelper databaseHelper;
  late Future<List<Carts>> cartsList;

  bool turn = true;
  bool payConfirm = false;
  List<Carts> carts = [];
  int len = 0;

  PaymentProvider() {
    databaseHelper = DatabaseHelper();
    loadData();
  }

  Future<void> loadData() async {
    cartsList = databaseHelper.getCarts();
    carts = await cartsList;
    len = carts.length;
    notifyListeners();
  }

  void togglePaymentMethod(bool isOn) {
    turn = isOn;
    notifyListeners();
  }

  Future<void> makeCardPayment(BuildContext context, String amount) async {
    // payConfirm = false;
    await makePayment(
      context,
      amount,
      "Payment Successful!",
      "Your payment has been successfully processed.",
      AlertType.success,
      false,
      databaseHelper,
      carts,
    );
  }

  void setPayConfirm(bool value) {
    payConfirm = value;
    notifyListeners();
  }

  void confirmOrder(
      BuildContext context, DatabaseHelper databaseHelper, List<Carts> carts) {
    CustomAlertDialog.onAlertWithStyle(
      context,
      "Order Confirmed!",
      "Your order has been confirmed successfully",
      AlertType.success,
      false,
      databaseHelper,
      carts,
    );
  }
}
