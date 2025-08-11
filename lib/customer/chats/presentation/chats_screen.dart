import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaruDarki,
        title: Text("Chats Screen"),
      ),
    );
  }
}
