import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:fitai/networks/api_acess.dart';

import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/navigation_service.dart';
import '../model/privacy_policy_model.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch privacy policy data from the API
    getPrivacyPolicyRx.fetchPrivacyPolicyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            NavigationService.goBack();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.c000000,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: TextFontStyle.headline20w500c000000StyleInter,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: getPrivacyPolicyRx.getPrivacyPolicyData,
              builder: (context, snapshot) {
                // Show loading indicator while waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  log("Loading Privacy Policy...");
                  return const WaitingWidget();
                }

                // Handle null or empty snapshot
                if (!snapshot.hasData || snapshot.data == null) {
                  log("Privacy Policy data is null");
                  return const NotFoundWidget();
                }

                try {
                  // Parse JSON safely
                  final privacyPolicy = PrivacyPolicyModel.fromJson(
                      snapshot.data as Map<String, dynamic>);
                  final data = privacyPolicy.data;

                  // If content is null or empty, show NotFoundWidget
                  if (data == null ||
                      data.content == null ||
                      data.content!.isEmpty) {
                    log("Privacy Policy content is empty");
                    return const NotFoundWidget();
                  }

                  // Display the privacy policy content
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.content!,
                        style: TextFontStyle.headline14w400c000000StyledmSans,
                      ),
                    ],
                  );
                } catch (e) {
                  log("Error parsing PrivacyPolicyModel: $e");
                  return const NotFoundWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
