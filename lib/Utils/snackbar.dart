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
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 650, left: 3, right: 3),
        content: Text(
          title,
          style: GoogleFonts.cabin(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
