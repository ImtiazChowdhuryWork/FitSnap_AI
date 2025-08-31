import 'package:fitsnap_ai/common_widgets/custom_text_form_field.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/features/explore/presentation/widget/explore_category_card.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Section : Search Bar
                CustomFormField(
                  hintText: "Search here",
                  borderColor: AppColors.c0B61D4,
                  suffixIcon: Icon(
                    Icons.search_outlined,
                    color: AppColors.c0B61D4,
                  ),
                ),
                UIHelper.verticalSpace(20.h),

                ///Section : Workout Categories Text
                Text(
                  "Workout Categories",
                  style: TextFontStyle.headline20w500c000000StyleInter,
                ),
                UIHelper.verticalSpace(20.h),

                ///Section : Workout Categories
                SizedBox(
                  width: 1.sw,
                  child: ListView.builder(
                    itemCount: 100,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ExploreCategoryCard();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
