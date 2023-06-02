import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/screens/payment_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Reusable Components/contact_page.dart';

class ContactScreen extends StatefulWidget {
  final String amount;
  const ContactScreen({required this.amount, Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class UserInfo {
  String name;
  String email;
  String phone;
  String address;

  UserInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
}

class _ContactScreenState extends State<ContactScreen> {
  late SharedPreferences _prefs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isFormValid = false;
  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = _prefs.getString('name') ?? '';
      emailController.text = _prefs.getString('email') ?? '';
      phoneController.text = _prefs.getString('phone') ?? '';
      addressController.text = _prefs.getString('address') ?? '';
    });
    validateForm();
  }

  Future<void> saveUserInfo(UserInfo userInfo) async {
    await _prefs.setString('name', userInfo.name);
    await _prefs.setString('email', userInfo.email);
    await _prefs.setString('phone', userInfo.phone);
    await _prefs.setString('address', userInfo.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
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
                padding: const EdgeInsets.only(top: 15, left: 25, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact',
                      style: GoogleFonts.cabin(fontSize: 26),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Column(
                children: [
                  Column(
                    children: [
                      ContactPage(
                        title: 'Name',
                        hint: 'Enter Your Name',
                        type: TextInputType.text,
                        controller: nameController,
                        onChanged: (String value) => validateForm(),
                      ),
                      ContactPage(
                        title: 'Email',
                        hint: 'Enter Your Email Address',
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        onChanged: (String value) => validateForm(),
                      ),
                      ContactPage(
                        title: 'Contact',
                        hint: 'Enter Your Phone no',
                        type: TextInputType.phone,
                        controller: phoneController,
                        onChanged: (String value) => validateForm(),
                      ),
                      ContactPage(
                        title: 'Address',
                        hint: 'Enter Your Current Address',
                        type: TextInputType.text,
                        controller: addressController,
                        onChanged: (String value) => validateForm(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 25),
                        child: Text(
                          'Make sure to write the current address and active phone number '
                          'as it will be used to deliver your item.',
                          style: GoogleFonts.cabin(
                              fontSize: 12, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 60,
                    padding: const EdgeInsets.only(top: 22, right: 20),
                    child: ElevatedButton(
                      onPressed: isFormValid
                          ? () {
                              saveUserInformation();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                          amount: widget.amount)));
                            }
                          : null,
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 10,

                        //padding: EdgeInsets.symmetric(horizontal: 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void validateForm() {
    setState(() {
      isFormValid = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          addressController.text.isNotEmpty;
    });
  }

  void saveUserInformation() {
    UserInfo userInfo = UserInfo(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
    );
    saveUserInfo(userInfo);
  }
}
