import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:food_delivery_app_ui/screens/home_screen.dart';
import 'package:food_delivery_app_ui/screens/payment_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlertDialog {
  static void onAlertWithStyle(
      BuildContext context,
      String title,
      String desc,
      AlertType alertType,
      bool payConfirm,
      DatabaseHelper databaseHelper,
      List<Carts> carts) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromBottom,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: GoogleFonts.cabin(
          fontSize: 16,
        ),
        animationDuration: const Duration(milliseconds: 600),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: GoogleFonts.cabin(
            fontSize: 23, color: Colors.green, fontWeight: FontWeight.w600),
        constraints: const BoxConstraints.expand(
          width: 320,
        ),
        overlayColor: const Color(0x55000000),
        alertElevation: 4,
        alertPadding: const EdgeInsets.only(top: 200),
        alertAlignment: Alignment.bottomCenter);

    Alert(
      context: context,
      style: alertStyle,
      type: alertType,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          height: 35,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 45),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            turn = true;
            payConfirm = false;
            for (Carts cart in carts) {
              databaseHelper.delete(cart.id!);
            }
          },
          child: Center(
            child: Text(
              'Return to Home Page',
              style: GoogleFonts.cabin(fontSize: 15.5, color: Colors.black),
            ),
          ),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          radius: BorderRadius.circular(40),
          color: Colors.transparent,
        ),
      ],
    ).show();
  }
}
