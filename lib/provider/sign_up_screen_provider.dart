import 'package:flutter/material.dart';

class SignUpScreenProvider extends ChangeNotifier {
  ///Password
  final bool _passwordHidden = true;
  bool get passwordMode => _passwordHidden;

  ///Set Password Mode
  void setPasswordMode() {
    _passwordHidden != _passwordHidden;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  TextEditingController eamilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
