import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/database/db_helper.dart';
import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:food_delivery_app_ui/model/food.dart';
import 'package:food_delivery_app_ui/model/order.dart';
import 'package:food_delivery_app_ui/model/restaurant.dart';
import 'package:food_delivery_app_ui/widgets/rating_stars.dart';
import 'package:intl/intl.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant? restaurant;

  const RestaurantScreen({this.restaurant, Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  DatabaseHelper? databaseHelper;

  late Future<List<Carts>> cartsList;

  int len = 0;
  bool fav = false;

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

  var q = 0;

  Widget _buildMenuItem(BuildContext context, Food menuItem, Order order) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 170.0,
          width: 170.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
              image: AssetImage(menuItem.imageUrl!),
              opacity: 0.88,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 170.0,
          width: 170.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.mirror,
              stops: const <double>[0.1, 0.5, 0.7, 0.9],
              colors: <Color>[
                Colors.black.withOpacity(0.3),
                Colors.black87.withOpacity(0.3),
                Colors.black54.withOpacity(0.3),
                Colors.black38.withOpacity(0.3),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              menuItem.name!,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              '\$${menuItem.price}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15.0,
          right: 15.0,
          child: Container(
            height: 36.0,
            width: 36.0,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.35),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(40)),
            child: IconButton(
              onPressed: () {
                var now = DateTime.now();
                var formatter = DateFormat('dd-MM-yyyy');
                String formattedDate = formatter.format(now);
                setState(() {
                  databaseHelper!
                      .insert(Carts(
                          date: formattedDate,
                          price: menuItem.price!.toDouble(),
                          food: menuItem.name.toString(),
                          restaurant: widget.restaurant!.name.toString(),
                          quantity: 1,
                          imageURL: menuItem.imageUrl.toString()))
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
                color: Colors.white,
                size: 16.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Hero(
                tag: widget.restaurant!.imageUrl!,
                child: Opacity(
                  opacity: 0.95,
                  child: Image.asset(
                    widget.restaurant!.imageUrl!,
                    height: 200.0,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          loadData();
                          Navigator.of(context).pop();
                          loadData();
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (fav == true) {
                            fav = false;
                          } else {
                            fav = true;
                          }
                        });
                      },
                      icon: fav
                          ? const Icon(
                              Icons.favorite,
                              size: 30.0,
                              color: Color(0xFF86DE29),
                            )
                          : const Icon(
                              Icons.favorite_border_sharp,
                              size: 30.0,
                              color: Color(0xFF86DE29),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.restaurant!.name!,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const Text(
                    //   '0.2 miles away',
                    //   style: TextStyle(
                    //     fontSize: 18.0,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 4.0),
                RatingStars(widget.restaurant!.rating!),
                const SizedBox(height: 6.0),
                Text(
                  widget.restaurant!.address!,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                child: const Text('Reviews'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30.0),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Contact'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color(0xFF86DE29)),
                  // backgroundColor: MaterialStateColor.resolveWith(
                  //
                  //   (states) => Theme.of(context).primaryColor,
                  // ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 11),
              itemCount: widget.restaurant!.menu!.length,
              itemBuilder: (context, index) {
                Food food = widget.restaurant!.menu![index];
                Order order = Order();
                return _buildMenuItem(context, food, order);
              },
            ),
          ),
        ],
      ),
    );
  }
}
