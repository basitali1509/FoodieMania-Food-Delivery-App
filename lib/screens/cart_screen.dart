import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/Utils/snackbar.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';

import 'package:food_delivery_app_ui/screens/contact_screen.dart';

import 'package:google_fonts/google_fonts.dart';

import '../database/db_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DatabaseHelper? databaseHelper;

  late Future<List<Carts>> cartsList;
  double totalPrice = 0;
  int deliveryTime = 0;
  int len = 0;
  bool isEmpty = true;
  @override
  void initState() {
    super.initState();

    databaseHelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    cartsList = databaseHelper!.getCarts();
    List<Carts> carts = await cartsList;
    isEmpty = carts.isEmpty;

    double newTotalPrice = 0;
    deliveryTime = carts.length * 15;
    for (var order in carts) {
      newTotalPrice += order.price * order.quantity;
    }
    setState(() {
      totalPrice = newTotalPrice;
      len = carts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  )),
              title: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 25, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cart',
                    style: GoogleFonts.cabin(fontSize: 26),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: cartsList,
                    builder: (context, AsyncSnapshot<List<Carts>> snapshot) {
                      // itemCount: snapshot.data!.length;
                      if (!snapshot.hasData) {
                        return const CircleAvatar(
                          radius: 35,
                          child: Icon(Icons.fastfood),
                        );
                      } else {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Carts order = snapshot.data![index];

                            return Container(
                              height: 100,
                              margin: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 108.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            snapshot.data![index].imageURL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          order.food,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          order.restaurant,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (order.quantity > 1) {
                                                    order.quantity -= 1;
                                                  }
                                                  databaseHelper!.update(order);
                                                  loadData();
                                                });
                                              },
                                              child: Container(
                                                width: 25.0,
                                                height: 25.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Text(
                                                order.quantity.toString(),
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  order.quantity += 1;

                                                  if (kDebugMode) {
                                                    print(
                                                        totalPrice.toString());
                                                  }
                                                  databaseHelper!.update(order);
                                                  loadData();
                                                });
                                              },
                                              child: Container(
                                                width: 25.0,
                                                height: 25.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 18.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              databaseHelper!
                                                  .delete(order.id!.toInt());
                                              loadData();
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 24,
                                          )),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Text(
                                          '\$${order.price}',
                                          style: const TextStyle(
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    })),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.95),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Delivery Time:',
                          style: GoogleFonts.cabin(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          deliveryTime.toString() + ' min',
                          style: GoogleFonts.cabin(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Cost:',
                          style: GoogleFonts.cabin(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.cabin(
                              fontSize: 17,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactScreen(
                                        amount: (totalPrice + 1)
                                            .toInt()
                                            .toString())));
                          } else {
                            snackBar.showSnackBar(context, 'Cart is empty');
                          }
                        },
                        child: Text(
                          'Payment',
                          style: GoogleFonts.cabin(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 12,
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
