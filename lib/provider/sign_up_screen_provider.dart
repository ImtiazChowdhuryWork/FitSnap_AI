import 'package:flutter/material.dart';

class SignUpScreenProvider extends ChangeNotifier {
  ///Password hidden state
  bool _passwordHidden = true;
  bool get passwordMode => _passwordHidden;

  ///Toggle Password Visibility
  void setPasswordMode() {
    _passwordHidden = !_passwordHidden;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  TextEditingController eamilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
