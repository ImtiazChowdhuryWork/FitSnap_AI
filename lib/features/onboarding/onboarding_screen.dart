import 'package:flutter/material.dart';

import '../../helpers/navigation_service.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///AppBar
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),

      ///Body
      body: Column(
        children: [Text("Who are you?")],
      ),
    );
  }
}
