import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../models/progress_history_model.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Weekly Progress",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black, size: 24.sp),
            onPressed: _loadProgressData,
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black, size: 24.sp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 24.sp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : _errorMessage.isNotEmpty
              ? _buildErrorState()
              : _buildProgressContent(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60.sp,
            color: Colors.grey[600],
          ),
          UIHelper.verticalSpace(16.h),
          Text(
            _errorMessage,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(20.h),
          ElevatedButton(
            onPressed: _loadProgressData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              "Retry",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Photos Section
          Row(
            children: [
              // Previous week photo
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 280.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: _currentProgress?.previousImage != null
                            ? Image.network(
                                "$baseUrl${_currentProgress!.previousImage!}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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
                        fontWeight: FontWeight.w500,
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
                      height: 280.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: _currentProgress?.currentImage != null
                            ? Image.network(
                                "$baseUrl${_currentProgress!.currentImage!}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          UIHelper.verticalSpace(32.h),

          // Date Section
          _buildInfoRow(
              "Date :", _currentProgress?.formattedDate ?? "No date available"),

          UIHelper.verticalSpace(16.h),

          // Status Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status :",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              UIHelper.verticalSpace(8.w),
              Text(
                _currentProgress?.status ?? "No status",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              // UIHelper.horizontalSpace(4.w),
              // Text(
              //   "💪",
              //   style: TextStyle(fontSize: 16.sp),
              // ),
            ],
          ),

          UIHelper.verticalSpace(24.h),

          // Difference Section
          if (_currentProgress?.differentiateFromPrevious != null) ...[
            Text(
              "Difference :",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              _currentProgress!.differentiateFromPrevious!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            UIHelper.verticalSpace(24.h),
          ],

          // Current Analysis Section
          if (_currentProgress?.currentAnalysis != null) ...[
            Text(
              "Current analysis :",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              _currentProgress!.currentAnalysis!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],

          // Tips Section
          if (_currentProgress?.tips != null) ...[
            UIHelper.verticalSpace(24.h),
            Text(
              "Tips :",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              _currentProgress!.tips!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],

          UIHelper.verticalSpace(40.h),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        size: 60.sp,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        UIHelper.horizontalSpace(8.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
