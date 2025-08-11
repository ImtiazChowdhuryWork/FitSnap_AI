import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaruDarki,
        title: Text("Profile Screen"),
      ),
    );
  }
}
