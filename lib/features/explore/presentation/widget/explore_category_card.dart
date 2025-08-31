import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class ExploreCategoryCard extends StatelessWidget {
  const ExploreCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
      child: Text(
        "Test",
        style: TextFontStyle.headline14w400c000000StyledmSans,
      ),
    );
  }
}
