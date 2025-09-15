import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../models/progress_history_model.dart';
import 'package:provider/provider.dart';
import '../../../provider/navigation_provider.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _isLoading = true;
  ProgressHistoryItem? _currentProgress;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProgressData();
  }

  Future<void> _loadProgressData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      bool success = await getProgressHistoryRx.getProgressHistory();
      if (success && getProgressHistoryRx.progressHistory.isNotEmpty) {
        setState(() {
          _currentProgress = getProgressHistoryRx.progressHistory.first;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = getProgressHistoryRx.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load progress data';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: AppColors.c0000ff,
        title: const Text(
          "Weekly Progress",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadProgressData,
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.c0000ff,
                  ),
                )
              : _errorMessage.isNotEmpty
                  ? _buildErrorState()
                  : _buildProgressContent(),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.c0000ff.withOpacity(0.1),
              AppColors.c0000ff.withOpacity(0.05),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.c0000ff.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.c0000ff.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                color: AppColors.c0000ff.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.show_chart_rounded,
                size: 48.sp,
                color: AppColors.c0000ff,
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              "Track Your Progress",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Message
            Text(
              "You need to take your body image using AI cam to track your fitness progress over time",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),

            // Button
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.c0000ff, Color(0xFF2563EB)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.c0000ff.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to AI cam screen using navigation provider
                  final navigationProvider =
                      Provider.of<NavigationProvider>(context,
                          listen: false);
                  navigationProvider
                      .setIndex(2); // AI cam is at index 2
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Take Body Image",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Photos Section
          Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress Photos",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                Row(
                  children: [
                    // Previous week photo
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 280.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.grey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: _currentProgress?.previousImage != null
                                  ? Image.network(
                                      "$baseUrl${_currentProgress!.previousImage!}",
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildPlaceholderImage();
                                      },
                                    )
                                  : _buildPlaceholderImage(),
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Text(
                            "Last week",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    UIHelper.horizontalSpace(16.w),
                    // Current week photo
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 280.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.grey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: _currentProgress?.currentImage != null
                                  ? Image.network(
                                      "$baseUrl${_currentProgress!.currentImage!}",
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildPlaceholderImage();
                                      },
                                    )
                                  : _buildPlaceholderImage(),
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Text(
                            "This week",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          UIHelper.verticalSpace(24.h),

          // Progress Details Section
          Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress Details",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                UIHelper.verticalSpace(20.h),

                // Date Section
                _buildInfoRow("Date",
                    _currentProgress?.formattedDate ?? "No date available"),

                UIHelper.verticalSpace(16.h),

                // Status Section
                _buildInfoRow(
                    "Status", _currentProgress?.status ?? "No status"),

                UIHelper.verticalSpace(16.h),

                // Difference Section
                if (_currentProgress?.differentiateFromPrevious != null) ...[
                  Text(
                    "Difference",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: AppColors.c0000ff.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _currentProgress!.differentiateFromPrevious!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                ],

                // Current Analysis Section
                if (_currentProgress?.currentAnalysis != null) ...[
                  Text(
                    "Current Analysis",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _currentProgress!.currentAnalysis!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                ],

                // Tips Section
                if (_currentProgress?.tips != null) ...[
                  Text(
                    "Tips",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _currentProgress!.tips!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          UIHelper.verticalSpace(40.h),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 60.sp,
            color: Colors.grey[600],
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            "No image",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          UIHelper.horizontalSpace(12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
