import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:fitsnap_ai/networks/api_acess.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/navigation_service.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    getPrivacyPolicyRx.fetchPrivacyPolicyData();
  }

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
          "Privacy Policy",
          style: TextFontStyle.headline20w500c000000StyleInter,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: (getPrivacyPolicyRx.getPrivacyPolicyData),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  log("Waitttttttttttttttttttttingggggggggg_________Privacy Policyyyyy");
                  return const WaitingWidget();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Column(
                    children: [Text("Api Data Found")],
                  );
                } else {
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
