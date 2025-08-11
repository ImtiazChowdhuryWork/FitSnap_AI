import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaruDarki,
        title: Text("Bookings Screen"),
      ),
    );
  }
}
