import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  bool showIntroduction = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  void _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (!isFirstTime) {
      setState(() {
        showIntroduction = false;
      });
    } else {
      prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showIntroduction ? _buildIntroductionScreen() : _navigateToHome(),
    );
  }

  Widget _buildIntroductionScreen() {
    final googleFontsMedium =
        GoogleFonts.creteRound(fontSize: 19, letterSpacing: 1.5);
    final googleFontsLarge =
        GoogleFonts.creteRound(fontSize: 25, letterSpacing: 1.5);
    final googleFontsSmall =
        GoogleFonts.breeSerif(fontSize: 16, letterSpacing: 1.5);

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/delivery.json',
                width: 300,
                height: 300,
                reverse: true,
                animate: true,
                fit: BoxFit.contain,
                repeat: true,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Delicious Food', style: googleFontsLarge),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text.rich(
                          TextSpan(
                            text: 'delivered to your doorsteps\n',
                            style: googleFontsMedium,
                            children: [
                              const WidgetSpan(child: SizedBox(height: 45)),
                              TextSpan(
                                text:
                                    'Satisfy your cravings with seamless food delivery service.\n',
                                style: googleFontsSmall,
                              ),
                              const WidgetSpan(child: SizedBox(height: 50)),
                              TextSpan(
                                text: 'Quick, easy, and mouthwatering!',
                                style: GoogleFonts.dancingScript(
                                    fontSize: 18.5, letterSpacing: 1.5),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 28, top: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())),
                    child: Container(
                      height: 40,
                      width: 60,
                      child: const Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF72BD22)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2, color: const Color(0xFF72BD22)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _navigateToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });

    return Center(
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
                        image: AssetImage('assets/images/burger_icon.png'))),
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
    );
  }
}
