import 'package:flutter/material.dart';

class SignInScreenController with ChangeNotifier {
  ///Email & Password Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///Password Visibility
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
