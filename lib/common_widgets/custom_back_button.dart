import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.goBack();
      },
      child: Icon(Icons.arrow_back_ios),
    );
  }
}
