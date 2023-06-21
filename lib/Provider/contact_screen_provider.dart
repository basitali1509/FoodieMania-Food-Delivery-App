import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isFormValid = false;

  ContactProvider() {
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    _prefs = await SharedPreferences.getInstance();
    nameController.text = _prefs.getString('name') ?? '';
    emailController.text = _prefs.getString('email') ?? '';
    phoneController.text = _prefs.getString('phone') ?? '';
    addressController.text = _prefs.getString('address') ?? '';
    validateForm();
  }

  Future<void> saveUserInfo() async {
    await _prefs.setString('name', nameController.text);
    await _prefs.setString('email', emailController.text);
    await _prefs.setString('phone', phoneController.text);
    await _prefs.setString('address', addressController.text);
  }

  void validateForm() {
    isFormValid = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
    notifyListeners();
  }

  void saveUserInformation() {
    saveUserInfo();
  }
}
