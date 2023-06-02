import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/Utils/alert_dialog.dart';
import 'package:food_delivery_app_ui/ViewModel/stripe_payment.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:food_delivery_app_ui/screens/cart_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/Reusable Components/animated_toggle_button.dart';
import '../database/db_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

bool turn = true;

class PaymentScreen extends StatefulWidget {
  final String amount;
  const PaymentScreen({required this.amount, Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntentData;
  bool payConfirm = false;

  DatabaseHelper? databaseHelper;

  late Future<List<Carts>> cartsList;

  late List<Carts> carts;
  int len = 0;
  void togglePaymentMethod(bool isOn) {
    setState(() {
      turn = isOn;
    });
  }

  @override
  void initState() {
    super.initState();

    databaseHelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    cartsList = databaseHelper!.getCarts();
    carts = await cartsList;

    setState(() {
      len = carts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      payConfirm = false;
                      turn = true;
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              title: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment',
                    style: GoogleFonts.cabin(fontSize: 26),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(30),
                          padding: const EdgeInsets.all(18),
                          height: 160,
                          width: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1.5,
                                blurRadius: 3.2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade400,
                                Colors.blueAccent.shade200
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  'Total Balance',
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                '\$${widget.amount}',
                                style: GoogleFonts.cabin(
                                    fontSize: 36,
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartScreen()),
                                  );
                                  setState(() {
                                    turn = true;
                                  });
                                },
                                child: Container(
                                  height: 28,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white70.withOpacity(0.7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'View Cart',
                                      style: GoogleFonts.cabin(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AnimatedToggleButton(
                          isOn: turn,
                          onToggle: togglePaymentMethod,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      turn
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25, left: 20, bottom: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Card Payment',
                                        style: GoogleFonts.cabin(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: () async {
                                      setState(() {
                                        payConfirm = false;
                                      });
                                      await makePayment(
                                          context,
                                          widget.amount,
                                          "Payment Successful!",
                                          "Your payment has been successfully processed.",
                                          AlertType.success,
                                          payConfirm,
                                          databaseHelper!,
                                          carts);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 38,
                                        width: 230,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.blue,
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.payment_rounded,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Make Payment',
                                                style: GoogleFonts.cabin(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25, left: 20, bottom: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cash On Delivery',
                                        style: GoogleFonts.cabin(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      payConfirm = true;
                                    });
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF86DE29),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        payConfirm
                                            ? const Icon(
                                                Icons.circle,
                                                color: Colors.white,
                                                size: 16,
                                              )
                                            : const Icon(
                                                Icons.circle_outlined,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Text(
                                          'Cash On Delivery',
                                          style: GoogleFonts.cabin(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                payConfirm
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 55,
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                CustomAlertDialog.onAlertWithStyle(
                                                    context,
                                                    "Order Confirmed!",
                                                    "Your order has been confirmed successfully",
                                                    AlertType.success,
                                                    payConfirm,
                                                    databaseHelper!,
                                                    carts);
                                              },
                                              child: Text(
                                                'Confirm Order',
                                                style: GoogleFonts.cabin(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 12,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
