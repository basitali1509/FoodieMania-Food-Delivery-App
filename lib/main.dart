import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app_ui/screens/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      '{publishable-key}';

  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodieMania: Food Delivery App',
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.red,
      ),
      home: const IntroductionScreen(),
    );
  }
}
