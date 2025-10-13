import 'dart:developer';
import 'package:fitai/features/meal/models/meal_plan_model.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:fitai/networks/api_acess.dart';
import 'package:fitai/common_widgets/waiting_widget.dart';
import 'package:fitai/common_widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../../../provider/navigation_provider.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    getMealPlanRx.getMealPlan();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.c0000ff,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      // Refresh meal plan data - you may need to modify this based on your API
      getMealPlanRx.getMealPlan();
    }
  }

  void _clearDateFilter() {
    setState(() {
      _selectedDate = null;
    });
    getMealPlanRx.getMealPlan();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: AppColors.c0000ff,
        title: const Text("Meal Plan", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _selectDate,
          ),
          if (_selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: _clearDateFilter,
            ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              getMealPlanRx.getMealPlan();
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getMealPlanRx.getMealPlanData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: WaitingWidget());
          } else if (snapshot.hasData && snapshot.data != null) {
            MealPlanModel mealPlan = MealPlanModel.fromJson(snapshot.data);
            
            // Filter meal plans by selected date if any
            List<MealPlanData> filteredData = mealPlan.data ?? [];
            if (_selectedDate != null) {
              filteredData = filteredData.where((planData) {
                if (planData.date == null) return false;
                try {
                  DateTime planDate = DateTime.parse(planData.date!);
                  return _isSameDay(planDate, _selectedDate!);
                } catch (e) {
                  return false;
                }
              }).toList();
            }
            
            // Check if meal plan data exists and has items
            if (filteredData.isEmpty) {
              return _buildErrorState();
            }

            return Column(
              children: [
                // Date Filter Info
                if (_selectedDate != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.sp),
                    margin: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: AppColors.c0000ff.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.c0000ff.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: AppColors.c0000ff,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Filtered by: ${DateFormat('MMM dd, yyyy').format(_selectedDate!)}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.c0000ff,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Content
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final planData = filteredData[index];
                      return Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Card with Goal & Calories
                            _buildHeaderCard(planData),
                            UIHelper.verticalSpace(16.h),
                        
                            // Macros Card
                            if (planData.macrosInfo != null)
                              _buildMacrosCard(planData.macrosInfo!),
                            UIHelper.verticalSpace(16.h),
                        
                            // Meals Section
                            Text(
                              "Daily Meals",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.c000000,
                              ),
                            ),
                            UIHelper.verticalSpace(12.h),
                        
                            // Meals List
                            if (planData.meals != null && planData.meals!.isNotEmpty)
                              ...planData.meals!.map((meal) => _buildMealCard(meal)),
                        
                            UIHelper.verticalSpace(16.h),
                        
                            // Hydration Info Card
                            if (planData.hydrationInfo != null)
                              _buildHydrationCard(planData.hydrationInfo!),
                            UIHelper.verticalSpace(16.h),
                        
                            // Swap Options Card
                            if (planData.swapsInfo != null)
                              _buildSwapsCard(planData.swapsInfo!),
                            UIHelper.verticalSpace(16.h),
                        
                            // Notes Card
                            if (planData.notes != null)
                              _buildNotesCard(planData.cleanNotes),
                        
                            UIHelper.verticalSpace(32.h),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: NotFoundWidget());
          }
        },
      ),
    );
  }

  Widget _buildHeaderCard(MealPlanData planData) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.c0000ff, AppColors.c0000ff.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.c0000ff.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Row
          if (planData.date != null && planData.date!.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 20.sp),
                UIHelper.horizontalSpace(8.w),
                Text(
                  planData.formattedDate,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
          ],
          
          Row(
            children: [
              Icon(Icons.flag, color: Colors.white, size: 24.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Your Goal",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            planData.cleanGoal,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
          UIHelper.verticalSpace(16.h),
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange, size: 24.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Daily Target",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            planData.cleanCalories,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacrosCard(MacrosInfo macros) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: AppColors.c0000ff, size: 24.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Daily Macros",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.c000000,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          Row(
            children: [
              Expanded(child: _buildMacroItem("Protein", macros.cleanProtein, Colors.red)),
              Expanded(child: _buildMacroItem("Carbs", macros.cleanCarbs, Colors.blue)),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Row(
            children: [
              Expanded(child: _buildMacroItem("Fat", macros.cleanFat, Colors.green)),
              Expanded(child: _buildMacroItem("Fiber", macros.cleanFiber, Colors.orange)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String title, String value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(MealItem meal) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColors.c0000ff.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  meal.mealEmoji,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.mealType,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.c000000,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, size: 16.sp, color: Colors.orange),
                        UIHelper.horizontalSpace(4.w),
                        Expanded(
                          child: Text(
                            meal.formattedCalories,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(12.w),
                        Icon(Icons.fitness_center, size: 16.sp, color: Colors.blue),
                        UIHelper.horizontalSpace(4.w),
                        Text(
                          "${meal.formattedProtein} protein",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            meal.cleanDescription,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.c000000.withOpacity(0.7),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHydrationCard(HydrationInfo hydration) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop, color: Colors.blue, size: 24.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Hydration Guide",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            hydration.cleanHydration,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blue.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapsCard(SwapsInfo swaps) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horiz, color: Colors.green, size: 24.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Alternative Options",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          if (swaps.vegetarian != null) ...[
            Text(
              "Vegetarian Options:",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            UIHelper.verticalSpace(4.h),
            Text(
              swaps.cleanVegetarian,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.green.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            UIHelper.verticalSpace(12.h),
          ],
          if (swaps.easyOptions != null) ...[
            Text(
              "Quick & Easy Options:",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            UIHelper.verticalSpace(4.h),
            Text(
              swaps.cleanEasyOptions,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.green.withOpacity(0.8),
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotesCard(String notes) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.orange, size: 24.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Important Notes",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            notes,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.orange.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    // Check if we have a selected date and it's not today
    bool isDateFiltered = _selectedDate != null;
    bool isNotToday = _selectedDate != null && 
        !_isSameDay(_selectedDate!, DateTime.now());
    
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
                isDateFiltered && isNotToday 
                    ? Icons.calendar_today_outlined 
                    : Icons.restaurant_menu_rounded,
                size: 48.sp,
                color: AppColors.c0000ff,
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              isDateFiltered && isNotToday 
                  ? "No Meal Plan Available"
                  : "Get Personalized Meal Plans",
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
              isDateFiltered && isNotToday
                  ? "No meal plan was created for ${DateFormat('MMM dd, yyyy').format(_selectedDate!)}. Meal plans are typically generated after body image analysis."
                  : "You need to take your body image using AI cam to get personalized meal recommendations",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),

            // Button - only show if it's today or no date filter
            if (!isDateFiltered || !isNotToday)
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
}
