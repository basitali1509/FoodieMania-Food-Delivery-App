import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '/model/order.dart';
import '/data/data.dart';

class PopularItems extends StatefulWidget {
  const PopularItems({Key? key}) : super(key: key);

  @override
  State<PopularItems> createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {
  DatabaseHelper? databaseHelper;

  late Future<List<Carts>> cartsList;

  double totalPrice = 0;

  @override
  void initState() {
    super.initState();

    databaseHelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    cartsList = databaseHelper!.getCarts();
    List<Carts> carts = await cartsList;
    double newTotalPrice = 0;
    for (var order in carts) {
      newTotalPrice += order.price * order.quantity;
    }
    setState(() {
      totalPrice = newTotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            'Popular Items',
            style: GoogleFonts.cabin(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 18.0,
        ),
        SizedBox(
          height: 225.0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            scrollDirection: Axis.horizontal,
            itemCount: currentUser.orders!.length,
            itemBuilder: (context, index) {
              Order order = currentUser.orders![index];
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 165.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        child: Image.asset(
                          order.food!.imageUrl!,
                          height: 95.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.food!.name!,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              order.restaurant!.name!,
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              order.date!,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${order.food!.price!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 32.0,
                              height: 32.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  var now = DateTime.now();
                                  var formatter = DateFormat('dd-MM-yyyy');
                                  String formattedDate = formatter.format(now);

                                  setState(() {
                                    databaseHelper!
                                        .insert(Carts(
                                            date: formattedDate,
                                            price:
                                                order.food!.price!.toDouble(),
                                            food: order.food!.name.toString(),
                                            restaurant: order.restaurant!.name
                                                .toString(),
                                            quantity: 1,
                                            imageURL: order.food!.imageUrl
                                                .toString()))
                                        .then((value) {
                                      if (kDebugMode) {
                                        print('cart inserted. $value');
                                      }
                                    }).onError((error, stackTrace) {
                                      print('error: ' + error.toString());
                                    });
                                    loadData();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
