import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class TermsAndServicesScreen extends StatelessWidget {
  const TermsAndServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            NavigationService.goBack;
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.c000000,
          ),
        ),
        title: Text(
          "Terms & conditions",
          style: TextFontStyle.headline20w500c000000StyleInter,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
