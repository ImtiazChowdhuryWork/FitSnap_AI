import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.c0000ff,
        title: Text("Workouts Plan Screen"),
      ),
    );
  }
}
