import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/Utils/alert_dialog.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

Map<String, dynamic>? paymentIntentData;
Future<void> makePayment(
    BuildContext context,
    String amount,
    String title,
    String desc,
    AlertType alertType,
    bool payConfirm,
    DatabaseHelper databaseHelper,
    List<Carts> carts) async {
  try {
    paymentIntentData = await createPaymentIntent(amount, 'USD');

    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                setupIntentClientSecret:
                    '{secret-key}',
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customFlow: true,
                style: ThemeMode.dark,
                merchantDisplayName: 'Basit'))
        .then((value) {});

    displayPaymentSheet(
        context, title, desc, alertType, payConfirm, databaseHelper, carts);
  } catch (e, s) {
    if (kDebugMode) {
      print('Payment Exception: $e$s');
    }
  }
}

displayPaymentSheet(
    BuildContext context,
    String title,
    String desc,
    AlertType alertType,
    bool payConfirm,
    DatabaseHelper databaseHelper,
    List<Carts> carts) async {
  try {
    await Stripe.instance.presentPaymentSheet().then((newValue) {
      CustomAlertDialog.onAlertWithStyle(
          context, title, desc, alertType, payConfirm, databaseHelper, carts);

      paymentIntentData = null;
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('Exception/DISPLAYPAYMENTSHEET: $error $stackTrace');
      }
    });
  } on StripeException catch (e) {
    if (kDebugMode) {
      print('Exception/DISPLAYPAYMENTSHEET: $e');
    }
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              content: Text("Cancelled"),
            ));
  } catch (e) {
    if (kDebugMode) {
      print('$e');
    }
  }
}

createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
    };

    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer {secret-key}',
          'Content-Type': 'application/x-www-form-urlencoded'
        });

    return jsonDecode(response.body);
  } catch (err) {
    if (kDebugMode) {
      print('err charging user: ${err.toString()}');
    }
  }
}

calculateAmount(String amount) {
  final a = (int.parse(amount)) * 100;
  return a.toString();
}
