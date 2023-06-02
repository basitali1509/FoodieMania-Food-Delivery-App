import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/popular_items.dart';
import '/widgets/nearby_restaurants.dart';
import '/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper? databaseHelper;
  TextEditingController searchController = TextEditingController();
  late Future<List<Carts>> cartsList;

  int len = 0;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();

    loadData();
  }

  loadData() async {
    cartsList = databaseHelper!.getCarts();
    List<Carts> carts = await cartsList;
    setState(() {
      len = carts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 175,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 55, bottom: 20, left: 25, right: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('FoodieMania',
                              style: GoogleFonts.lobster(
                                  fontSize: 25, color: Colors.white)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                loadData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()));
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 56,
                              decoration: BoxDecoration(
                                  color: Color(0xFF86DE29),
                                  borderRadius: BorderRadius.circular(8)),
                              child: len != 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 22,
                                        ),
                                        CircleAvatar(
                                          radius: 9,
                                          backgroundColor: Colors.black,
                                          child: Text(
                                            len.toString(),
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        )
                                      ],
                                    )
                                  : Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 25,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 25,
                      ),
                      child: Container(
                        height: 38,
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            fillColor: Color(0xFF3B3A3A),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 0.8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 22,
                            ),
                            hintText: 'Search Food or Restaurants',
                            hintStyle: GoogleFonts.cabin(
                              fontSize: 14.5,
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 8,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: const [
                PopularItems(),
                NearbyRestaurants(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
