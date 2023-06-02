import '/model/food.dart';
import '/model/order.dart';
import '/model/restaurant.dart';
import '/model/user.dart';

// Food
final _burrito =
    Food(imageUrl: 'assets/images/burrito.jpg', name: 'Burrito', price: 8.99);
final _steak =
    Food(imageUrl: 'assets/images/steak.jpg', name: 'Steak', price: 17.99);
final _pasta =
    Food(imageUrl: 'assets/images/pasta.jpg', name: 'Pasta', price: 14.99);
final _ramen =
    Food(imageUrl: 'assets/images/ramen.jpg', name: 'Ramen', price: 13.99);
final _pancakes =
    Food(imageUrl: 'assets/images/pancakes.jpg', name: 'Pancakes', price: 9.99);
final _burger =
    Food(imageUrl: 'assets/images/burger.jpg', name: 'Burger', price: 14.99);
final _pizza =
    Food(imageUrl: 'assets/images/pizza.jpg', name: 'Pizza', price: 11.99);
final _salmon = Food(
    imageUrl: 'assets/images/salmon.jpg', name: 'Salmon Salad', price: 12.99);

// Restaurants
final _restaurant0 = Restaurant(
  imageUrl: 'assets/images/restaurant0.jpg',
  name: 'Pizzalicious Restaurant',
  address: '123 Main St, New York, NY',
  rating: 5,
  menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant1 = Restaurant(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Delicious Bites',
  address: '456 Elm St, New York, NY',
  rating: 4,
  menu: [_steak, _pasta, _ramen, _pancakes, _burger, _pizza],
);
final _restaurant2 = Restaurant(
  imageUrl: 'assets/images/restaurant2.jpg',
  name: 'Gourmet Fusion',
  address: '789 Oak St, New York, NY',
  rating: 4,
  menu: [_steak, _pasta, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant3 = Restaurant(
  imageUrl: 'assets/images/restaurant3.jpg',
  name: 'Spice Paradise',
  address: '321 Pine St, New York, NY',
  rating: 2,
  menu: [_burrito, _steak, _burger, _pizza, _salmon],
);
final _restaurant4 = Restaurant(
  imageUrl: 'assets/images/restaurant4.jpg',
  name: 'The Savory Spot',
  address: '654 Maple St, New York, NY',
  rating: 3,
  menu: [_burrito, _ramen, _pancakes, _salmon],
);
final _restaurant5 = Restaurant(
  imageUrl: 'assets/images/restaurant5.jpg',
  name: 'Cuisine Delights',
  address: '987 Walnut St, New York, NY',
  rating: 4,
  menu: [_ramen, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant6 = Restaurant(
  imageUrl: 'assets/images/restaurant6.jpg',
  name: 'Sizzlers Junction',
  address: '567 Cherry St, New York, NY',
  rating: 3,
  menu: [_burrito, _pasta, _pancakes, _salmon],
);

final List<Restaurant> restaurants = [
  _restaurant1,
  _restaurant5,
  _restaurant6,
  _restaurant0,
  _restaurant2,
  _restaurant3,
  _restaurant4,
];

// Popular Items
final currentUser = User(
  name: 'Basit',
  orders: [
    Order(
      date: 'Jun 2, 2023',
      food: _burger,
      restaurant: _restaurant5,
      quantity: 1,
    ),
    Order(
      date: 'Jun 2 , 2023',
      food: _pizza,
      restaurant: _restaurant3,
      quantity: 1,
    ),
    Order(
      date: 'Jun 3, 2023',
      food: _pasta,
      restaurant: _restaurant4,
      quantity: 1,
    ),
    Order(
      date: 'Jun 3, 2023',
      food: _steak,
      restaurant: _restaurant2,
      quantity: 1,
    ),
    Order(
      date: 'Jun 3, 2023',
      food: _ramen,
      restaurant: _restaurant0,
      quantity: 3,
    ),
    Order(
      date: 'Nov 5, 2019',
      food: _burrito,
      restaurant: _restaurant1,
      quantity: 2,
    ),
  ],
);
