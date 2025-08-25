import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../gen/colors.gen.dart';

SnackbarController CustomToastMessage({required title, required description}) {
  return Get.snackbar(title, description,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xff444444),
      colorText: AppColors.cFFFFFF);
}
