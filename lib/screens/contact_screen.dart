import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/screens/payment_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/contact_screen_provider.dart';
import '../Utils/Reusable Components/contact_page.dart';

class ContactScreen extends StatelessWidget {
  final String amount;

  const ContactScreen({required this.amount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  'Back',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 25, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact',
                      style: GoogleFonts.cabin(fontSize: 26),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child:
                  Consumer<ContactProvider>(builder: (context, provider, _) {
                return Column(
                  children: [
                    Column(
                      children: [
                        ContactPage(
                          title: 'Name',
                          hint: 'Enter Your Name',
                          type: TextInputType.text,
                          controller: provider.nameController,
                          onChanged: (String value) => provider.validateForm(),
                        ),
                        ContactPage(
                          title: 'Email',
                          hint: 'Enter Your Email Address',
                          type: TextInputType.emailAddress,
                          controller: provider.emailController,
                          onChanged: (String value) => provider.validateForm(),
                        ),
                        ContactPage(
                          title: 'Contact',
                          hint: 'Enter Your Phone no',
                          type: TextInputType.phone,
                          controller: provider.phoneController,
                          onChanged: (String value) => provider.validateForm(),
                        ),
                        ContactPage(
                          title: 'Address',
                          hint: 'Enter Your Current Address',
                          type: TextInputType.text,
                          controller: provider.addressController,
                          onChanged: (String value) => provider.validateForm(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 25,
                          ),
                          child: Text(
                            'Make sure to write the current address and active phone number '
                            'as it will be used to deliver your item.',
                            style: GoogleFonts.cabin(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      height: 60,
                      padding: const EdgeInsets.only(top: 22, right: 20),
                      child: ElevatedButton(
                        onPressed: provider.isFormValid
                            ? () {
                                provider.saveUserInformation();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                      amount: amount,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
