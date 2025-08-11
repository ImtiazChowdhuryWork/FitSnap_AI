import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class JobPostsScreen extends StatelessWidget {
  const JobPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaruDarki,
        title: Text("Job Posts Screen"),
      ),
    );
  }
}
