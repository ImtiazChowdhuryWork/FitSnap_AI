// import 'package:mollie/features/general_setting.dart/data/rx_update_profile/rx.dart';
// import 'package:mollie/features/remainder/data/rx_get_all_reminders/rx.dart';
// import 'package:mollie/features/remainder/data/rx_post_status/rx.dart';
// import 'package:mollie/features/remainder/data/rx_put_update_reminders/rx.dart';
// import 'package:rxdart/subjects.dart';

// import '../features/authentication/data/otp/rx.dart';
// import '../features/authentication/data/reset_password_otp/rx.dart';
// import '../features/authentication/data/rx_delete_account/rx.dart';
// import '../features/authentication/data/rx_email/rx.dart';
// import '../features/authentication/data/rx_forget_pw/rx.dart';
// import '../features/authentication/data/rx_login/rx.dart';
// import '../features/authentication/data/rx_logout/rx.dart';
// import '../features/authentication/data/rx_post_social_login/rx.dart';
// import '../features/authentication/data/rx_signup/rx.dart';
// import '../features/authentication/model/login_response.dart';
// import '../features/category/data/rx.dart';
// import '../features/collection/data/rx_delete_my_quote/rx.dart';
// import '../features/collection/data/rx_get_my_quote/rx.dart';
// import '../features/favourite/data/rx_get_fav/rx.dart';
// import '../features/favourite/data/rx_post_add_fav/rx.dart';
// import '../features/favourite/data/rx_post_delete_fav/rx.dart';
// import '../features/general_setting.dart/data/rx_get_profile/rx.dart';
// import '../features/home/data/rx_get_quotes/rx.dart';
// import '../features/quote/data/rx_add_quote/rx.dart';
// import '../features/remainder/data/rx_delete_remainder/rx.dart';
// import '../features/remainder/data/rx_post_reminders/rx.dart';
// import '../features/theme/data/rx.dart';

// GetLoginRX getLoginRXObj = GetLoginRX(
//     empty: LoginResponse(), dataFetcher: BehaviorSubject<LoginResponse>());

// GetSignUpRX getSignUpRXObj =
//     GetSignUpRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// VerifyOtpRX verifyOtpRX =
//     VerifyOtpRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// VerifyOtpFPRX verifyOtpFPRX =
//     VerifyOtpFPRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// LogOutRX logOutRX = LogOutRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostForgetEmailRX postForgetEmailRXObj =
//     PostForgetEmailRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostForgertPwRX postForgertPwRX =
//     PostForgertPwRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// GetProfileRX getProfileRX =
//     GetProfileRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// GetProfileRX getProfileRXObj =
//     GetProfileRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostUpdateProfileRX postUpdateProfileRX =
//     PostUpdateProfileRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// GetAllRemaindersRX getAllRemaindersRX =
//     GetAllRemaindersRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// DeleteRemainderRX deleteRemainderRX =
//     DeleteRemainderRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostAddRemainderRx postAddRemainderRx =
//     PostAddRemainderRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

// PutUpdateRemainderRX putUpdateRemainderRX =
//     PutUpdateRemainderRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostRemaniderStatusRx postRemaniderStatusRx =
//     PostRemaniderStatusRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
// GetCategoryByTypeRx getCategoryByTypeRx =
//     GetCategoryByTypeRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

// GetQuotesRx getQuotesRx =
//     GetQuotesRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

// GetFavQuotesRx getFavQuotesRx =
//     GetFavQuotesRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
// GetThemeRx getThemeRx =
//     GetThemeRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostAddFavRX postAddFavRX =
//     PostAddFavRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// GetMyQuotesRx getMyQuotesRx =
//     GetMyQuotesRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

// DeleteMyQuoteRX deleteMyQuoteRX =
//     DeleteMyQuoteRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// //old post

// //no lodder needed

// PostDeleteAccountRX postDeleteAccountRXObj =
//     PostDeleteAccountRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// PostForgertPwRX postForgertPwRXObj =
//     PostForgertPwRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// PostSocailLoginRX postSocailLoginRXObj =
//     PostSocailLoginRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// PostDeleteFavRX postDeleteFavRX =
//     PostDeleteFavRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

// PostAddQuoteRX postAddQuoteRX =
//     PostAddQuoteRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
// GetThemeRx getThemeRx =
//     GetThemeRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
//put
// PutUpdatePasswordRX putUpdatePasswordRXObj =
//     PutUpdatePasswordRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

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
