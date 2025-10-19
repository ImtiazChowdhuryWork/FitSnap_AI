

import 'package:fitai/features/auth/data/rx_post_sign_up/rx.dart';
import 'package:fitai/features/auth/presentation/sign_up/model/sign_up_model.dart';
import 'package:fitai/features/ai_cam/data/rx.dart';
import 'package:fitai/features/onboarding/data/rx.dart';
import 'package:fitai/features/onboarding/models/plan_intro_response_result.dart';
import 'package:fitai/features/my_plan/data/progress_history_rx.dart';
import 'package:fitai/features/workouts/data/suggested_workouts_rx.dart';
import 'package:fitai/features/meal/data/meal_plan_rx.dart';
import 'package:rxdart/subjects.dart';

import '../features/auth/data/rx_post_login/rx.dart';
import '../features/auth/data/rx_post_logout/rx.dart';
import '../features/explore/data/show_categories/rx.dart';
import '../features/explore/data/show_videos_according_selected_category/rx.dart';
import '../features/explore/model/show_selected_category_video_model/show_selected_category_video_model.dart';
import '../features/privacy_policy/data/rx.dart';
import '../features/profile/data/rx.dart';
import '../features/terms_of_services/data/rx.dart';

///FitSnapAI Start
PostSignUpRx postSignUpRx = PostSignUpRx(
    empty: SignUpModel(), dataFetcher: BehaviorSubject<SignUpModel>());

PostOnboardingRx postOnboardingRx = PostOnboardingRx(
    empty: PlanIntroResponseResulModel(),
    dataFetcher: BehaviorSubject<PlanIntroResponseResulModel>());

PostLoginRx postLoginRxObj =
    PostLoginRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetTermsOfServicesRx getTermsOfServicesRx =
    GetTermsOfServicesRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetPrivacyPolicyRx getPrivacyPolicyRx =
    GetPrivacyPolicyRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostLogOutRX postLogOutRX =
    PostLogOutRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetProfileInfoRx getProfileInfoRx =
    GetProfileInfoRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetExploreCategoriesRx getExploreCategoriesRx =
    GetExploreCategoriesRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

// GetSelectedCategoryVideoRx getSelectedCategoryVideoRx =
//     GetSelectedCategoryVideoRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
GetSelectedCategoryVideoRx getSelectedCategoryVideoRx =
    GetSelectedCategoryVideoRx(
        empty: ShowSelectedCategoryVideoModel(),
        dataFetcher: BehaviorSubject<ShowSelectedCategoryVideoModel?>());

AiCamUploadImageRx aiCamUploadImageRx =
    AiCamUploadImageRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetProgressHistoryRx getProgressHistoryRx =
    GetProgressHistoryRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetSuggestedWorkoutsRx getSuggestedWorkoutsRx =
    GetSuggestedWorkoutsRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetMealPlanRx getMealPlanRx =
    GetMealPlanRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

///FitSnapAI End
