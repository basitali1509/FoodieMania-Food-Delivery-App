import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class snackBar {
  static void showSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        margin: const EdgeInsets.only(bottom: 620, left: 5, right: 5),
        content: Text(
          title,
          style: GoogleFonts.cabin(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
