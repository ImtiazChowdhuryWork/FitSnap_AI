import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/all_routes.dart';

/// Custom Flutter Paywall for Testing
/// This paywall shows mock data and doesn't require RevenueCat configuration
/// Perfect for UI testing before store setup
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  String _selectedPlan = 'annual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.c0000ff.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: IconButton(
                    icon: Icon(Icons.close, size: 28.sp),
                    onPressed: () => NavigationService.goBack(),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      // Header
                      Text(
                        '🔥 Unlock Premium',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.c000000,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Get unlimited access to all features',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),

                      // Features list
                      _buildFeaturesList(),
                      SizedBox(height: 24.h),

                      // Subscription plans
                      _buildPlanCard(
                        title: 'Annual Plan',
                        price: '\$35.88/year',
                        priceDetail: 'Just \$2.99/week',
                        badge: 'SAVE 40%',
                        isSelected: _selectedPlan == 'annual',
                        onTap: () => setState(() => _selectedPlan = 'annual'),
                      ),
                      SizedBox(height: 10.h),
                      _buildPlanCard(
                        title: 'Weekly Plan',
                        price: '\$2.99/week',
                        priceDetail: 'Billed weekly',
                        badge: null,
                        isSelected: _selectedPlan == 'weekly',
                        onTap: () => setState(() => _selectedPlan = 'weekly'),
                      ),
                      SizedBox(height: 20.h),

                      // Subscribe button
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: ElevatedButton(
                          onPressed: () {
                            // For testing: Just navigate to sign up
                            NavigationService.navigateTo(Routes.signUpScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.c0000ff,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'Start Free Trial',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Continue for free
                      TextButton(
                        onPressed: () {
                          // Skip paywall and go to sign up
                          NavigationService.navigateTo(Routes.signUpScreen);
                        },
                        child: Text(
                          'Continue For Free',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Terms
                      Text(
                        'By subscribing you agree to our Terms of Service and Privacy Policy',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': '🤖', 'title': 'AI Cam Unlimited'},
      {'icon': '🎯', 'title': 'Suggested Workouts'},
      {'icon': '🍽️', 'title': 'Personalized Meals'},
      {'icon': '📊', 'title': 'Progress Tracking'},
      {'icon': '🎥', 'title': 'HD Workout Videos'},
      {'icon': '📱', 'title': 'Unlimited Access'},
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.c0000ff.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    feature['icon']!,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  feature['title']!,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c000000,
                  ),
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 22.sp,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String priceDetail,
    String? badge,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.c0000ff.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.c0000ff : Colors.grey[300]!,
            width: isSelected ? 2.w : 1.w,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.c0000ff.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Radio button
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.c0000ff : Colors.grey[400]!,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.c0000ff,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),

            // Plan info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.c000000,
                        ),
                      ),
                      if (badge != null) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    priceDetail,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Price
            Text(
              price,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.c0000ff,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
