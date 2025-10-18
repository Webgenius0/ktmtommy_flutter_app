import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/recent_madication_log_screen_data/get_all_medication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import 'package:rxdart/subjects.dart';

const String baseUrl = "https://ktmtommy.softvencefsd.xyz";

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

  // * >>>>>>>>>>>>>>>>>>>>> auth and forget <<<<<<<<<<<<<<<<<<<<<<<
  static String login() => "/api/login";

  ///========================My Day Section ========================///

  static String storeMedicationApi() => "/api/medication/store";
  static String allMedicationApi() => "/api/medication";
  static String deleteMedicationApi(dynamic  id) => "/api/medication/delete/$id";
  static String editMedicationApi(dynamic  id) => "/api//medication/update/$id";

}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway() => "/create-payment-intent";
}


GetAllMedicationRx getAllMedicationRxObj= GetAllMedicationRx(
  empty: AllMedicationModel(),
  dataFetcher: BehaviorSubject<AllMedicationModel>(),
);

