import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/Utils/snackbar.dart';
import 'package:food_delivery_app_ui/screens/contact_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_screen_provider.dart';
import '../database/db_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    await cartProvider.loadData();
    await cartProvider.loadHomePage();
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
                    // loadData();
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
            Expanded(child:
                Consumer<CartProvider>(builder: (context, cartProvider, _) {
              if (cartProvider.cartsList == null) {
                return const CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.fastfood),
                );
              } else {
                return FutureBuilder<List<Carts>>(
                    future: cartProvider.cartsList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Carts> carts = snapshot.data!;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Carts order =
                                carts[snapshot.data!.length - 1 - index];
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
                                        image: AssetImage(order.imageURL),
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
                                                cartProvider
                                                    .decrementQuantity(order);
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
                                                cartProvider
                                                    .incrementQuantity(order);
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
                                            cartProvider
                                                .deleteOrder(order.id!.toInt());
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
                      } else {
                        return const SizedBox();
                      }
                    });
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
                  child: Consumer<CartProvider>(
                      builder: (context, cartProvider, _) {
                    return Column(
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
                              cartProvider.deliveryTime.toString() + ' min',
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
                              '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
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
                              if (!cartProvider.isEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContactScreen(
                                            amount:
                                                (cartProvider.totalPrice + 1)
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
