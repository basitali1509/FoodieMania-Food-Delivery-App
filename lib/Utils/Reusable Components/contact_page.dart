import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  final String title, hint;
  TextEditingController controller;
  TextInputType type;
  final ValueChanged<String> onChanged;
  ContactPage(
      {required this.title,
      required this.hint,
      required this.type,
      required this.controller,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          child: Text(
            title,
            style: GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 25,
          ),
          child: SizedBox(
            height: 40,
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              keyboardType: type,
              style: GoogleFonts.cabin(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                  fillColor: Colors.white70,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  hintText: hint,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
