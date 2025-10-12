import 'dart:developer';

import 'package:fitai/common_widgets/not_found_widget.dart';
import 'package:fitai/common_widgets/waiting_widget.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:fitai/networks/api_acess.dart';
import 'package:flutter/material.dart';

import '../model/terms_of_services_model.dart';

class TermsAndServicesScreen extends StatefulWidget {
  const TermsAndServicesScreen({super.key});

  @override
  State<TermsAndServicesScreen> createState() => _TermsAndServicesScreenState();
}

class _TermsAndServicesScreenState extends State<TermsAndServicesScreen> {
  @override
  void initState() {
    super.initState();
    getTermsOfServicesRx.fetchTermsOfServicesData();
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
          "Terms & conditions",
          style: TextFontStyle.headline20w500c000000StyleInter,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: getTermsOfServicesRx.getTermsOfServiceData,
              builder: (context, snapshot) {
                // Show loading indicator while waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  log("Loading Terms & Conditions...");
                  return const WaitingWidget();
                }

                // Handle null or empty snapshot
                if (!snapshot.hasData || snapshot.data == null) {
                  log("Terms & Conditions data is null");
                  return const NotFoundWidget();
                }

                try {
                  // Parse JSON safely
                  final privacyPolicy = TermsOfServicesModel.fromJson(
                      snapshot.data as Map<String, dynamic>);
                  final data = privacyPolicy.data;

                  // If content is null or empty, show NotFoundWidget
                  if (data == null ||
                      data.content == null ||
                      data.content!.isEmpty) {
                    log("Terms & Conditions content is empty");
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
                  log("Error parsing Terms&ConditionsModel: $e");
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
