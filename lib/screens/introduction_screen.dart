import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ViewModel/splash_controller.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  SplashScreenController splashScreenController = SplashScreenController();

  @override
  void initState() {
    super.initState();
    splashScreenController.SplashTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 220,
            width: 220,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: Image(
                            image:
                                AssetImage('assets/images/burger_icon.png'))),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: Image(
                            image: AssetImage('assets/images/pizza_icon.png'))),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'FoodieMania',
                  style: GoogleFonts.lobster(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
