import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/recent_madication_log_screen_data/get_all_medication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import 'package:rxdart/subjects.dart';

const String baseUrl = "https://admin.mybalancedayapp.com";

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


  ///========================Profile Section====================================

  static String getProfile() => "/api/profile";
  static String logout() => "/api/logout";

  ///========================My Day Section ====================================

  static String storeMedicationApi() => "/api/medication/store";
  static String allMedicationApi() => "/api/medication";
  static String deleteMedicationApi(dynamic  id) => "/api/medication/delete/$id";
  static String editMedicationApi(dynamic  id) => "/api//medication/update/$id";

  ///=====================Log Steps Api Section ================================
  static String storeStepsApiPost() => "/api/step/store";
  static String allRecentGetApi() => "/api/step";
  static String deleteRecentStepApi(dynamic  id) => "/api/step/delete/$id";

  ///==================Log Activity Api Section=================================
  static String storeActivityApiPost() => "/api/activity/store";
  static String allActivityApi() => "/api/activity";
  static String deleteActivityApi(dynamic  id) => "/api/activity/delete/$id";

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
 static String deleteSleepGetApiLink({required dynamic id }) => "/api/sleep/delete/$id";
 static String deleteLogSupplementApiLink({required dynamic id }) => "/api/supplement/delete/$id";
 static String storeSupplementApiLink( ) => "/api/supplement/store";
 static String getLogSupplementApiLink( ) => "/api/supplement";




}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway() => "/create-payment-intent";
}


GetAllMedicationRx getAllMedicationRxObj= GetAllMedicationRx(
  empty: AllMedicationModel(),
  dataFetcher: BehaviorSubject<AllMedicationModel>(),
);

