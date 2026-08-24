import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/recent_madication_log_screen_data/get_all_medication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import 'package:rxdart/subjects.dart';

const String baseUrl = "https://admin.mybalancedayapp.com";
const String personImageUrl =
    "https://images.unsplash.com/photo-1729101143873-d80050bae219?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFucyUyMGdpcmx8ZW58MHx8MHx8fDA%3D";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

class Endpoints {
  Endpoints._();

  /// >>>>>>>>>>>>>>>>>>>>> auth and forget <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  static String login() => "/api/login";
  static String recoveryRegisterApi() => "/api/register";
  static String signUpAltheleteApiLink() => "/api/register";
  static String verifyOtp() => "/api/verify-otp";
  static String onboardingAthleteSignUpApiLink() => "/api/onboarding/athlete";
  static String generateMacroPlanApiLink() => "/api/athlete/generate-macro-plan";
  static String onboardingRecoverySignUpApiLink() => "/api/onboarding/recovery";
  static String changePasswordScreenApi() => "/api/password/update";
  static String postEditProfileApiLink() => "/api/onboarding/recovery";
  static String socialLogin() => "/api/social-login";

  ///========================Profile Section====================================

  static String getProfile() => "/api/profile";
  static String logout() => "/api/logout";
  static String deleteAccount() => "/api/accout/delete";

  ///========================My Day Section ====================================

  static String storeMedicationApi() => "/api/medication/store";
  static String storePrescribedMedicineApi() =>
      "/api/prescribed-medicine/store";
  static String getPrescribedMedicineApi() => "/api/prescribed-medicine";
  static String showPrescribedMedicineApi(dynamic id) =>
      "/api/prescribed-medicine/show/$id";
  static String updatePrescribedMedicineApi(dynamic id) =>
      "/api/prescribed-medicine/update/$id";
  static String deletePrescribedMedicineApi(dynamic id) =>
      "/api/prescribed-medicine/delete/$id";
  static String allMedicationApi() => "/api/medication";
  static String deleteMedicationApi(dynamic id) => "/api/medication/delete/$id";
  static String editMedicationApi(dynamic id) => "/api//medication/update/$id";

  ///=====================Log Steps Api Section ================================
  static String storeStepsApiPost() => "/api/step/store";
  static String allRecentGetApi() => "/api/step";
  static String deleteRecentStepApi(dynamic id) => "/api/step/delete/$id";

  ///==================Log Activity Api Section=================================
  static String storeActivityApiPost() => "/api/activity/store";
  static String allActivityApi() => "/api/activity";
  static String deleteActivityApi(dynamic id) => "/api/activity/delete/$id";
  static String getDailyActivities(String date) =>
      "/api/activity/daily?date=$date";

  ///================Log Food Section Api=======================================

  static String getAllFoodDataApi() => "/api/food";
  static String pstFoodScanApi() => "/api/food/analyze";
  static String postFoodStoreApi() => "/api/food/store";

  ///=================Add Equipments Section Api===============================
  static String addEquipments() => "/api/equipment/store";
  static String getAllEquipments() => "/api/equipment";

  ///>>>>>>>>>>>>>>>>>>> AI chat section >>>>>>>>>>>>>>>>>>>

  static String sendMessageForAi() => "/api/ai-chat/send-message";
  static String getChatList() => "/api/ai-chat/history";

  ///>>>>>>>>>>>>>>>>>>> sleep section >>>>>>>>>>>>>>>>>

  static String saveSleepPostApiLink() => "/api/sleep/store";
  static String saveSleepGetApiLink() => "/api/sleep";
  static String deleteSleepGetApiLink({required dynamic id}) =>
      "/api/sleep/delete/$id";
  static String deleteLogSupplementApiLink({required dynamic id}) =>
      "/api/supplement/delete/$id";
  static String storeSupplementApiLink() => "/api/supplement/store";
  static String getLogSupplementApiLink() => "/api/supplement";
  static String getFoodDailySummaryApi(String date) =>
      "/api/food/daily-summary?date=$date";
  static String dietitianSettingsApi() => "/api/dietitian/settings";
  static String updateTimezoneApi() => "/api/profile/timezone";
  static String scheduleFeedback(String fromDate, String toDate) =>
      "/api/schedule/feedback?from_date=$fromDate&to_date=$toDate";
  static String postScheduleFeedback() => "/api/schedule/feedback";
  static String storeSchedule() => "/api/schedule/store";
  static String getSchedule(String date) => "/api/schedule?date=$date";
  static String storeFcmToken() => "/api/firebase/token/add";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway() => "/create-payment-intent";
}

GetAllMedicationRx getAllMedicationRxObj = GetAllMedicationRx(
  empty: AllMedicationModel(),
  dataFetcher: BehaviorSubject<AllMedicationModel>(),
);
