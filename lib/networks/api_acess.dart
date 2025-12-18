import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/delate_sleep/rx.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/rx_get_recent_sleep/rx.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/save_sleep/rx.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/store_supliment/rx.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/GetAllSleep.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/data/athelete_auth_register_data/athlete_auth_register_rx.dart';
import 'package:ktmtommy_apps/features/auth/data/login_rx.dart';
import 'package:ktmtommy_apps/features/chat/data/rx_get_chat/rx.dart';
import 'package:ktmtommy_apps/features/chat/data/send_chat_rx/rx.dart';
import 'package:ktmtommy_apps/features/chat/model/chat_history.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/add_equipments_data/add_equipments_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/log_steps_screen_data/get_recent_step_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/log_steps_screen_data/log_steps_screen_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/steps_delate_data/delate_steps_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/model/get_recent_step_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/food_scan_post_api/food_scan_post_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/food_store_post_api/food_store_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/get_all_food_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/get_all_food_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/delete_medication_data/delete_medication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/edit_medication_data/edit_madication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/log_activity_data/log_activity_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/log_tablet_screen_store_data/store_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/data/get_all_equipment_data/get_all_equipment_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/get_all_equipment_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/data/log_out_data/log_out_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/recent_activity_log_get_data/delete_activity_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/recent_activity_log_get_data/get_recent_activity_log_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/registration_data/registration_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/model/recent_activity_log_model.dart';
import 'package:rxdart/subjects.dart';


///============Authentication Section==================///
LoginRx loginRxObj = LoginRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

RecoveryRegistrationApiRx recoveryRegistrationApiRxObj = RecoveryRegistrationApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

AthleteAuthRegisterRx athleteAuthRegisterRxObj = AthleteAuthRegisterRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);




///================== Medication Section Tablet , Food, Steps, Activity===== ///
StoreRx storeRxObj = StoreRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

LogStepsScreenRx logStepsScreenRxObj = LogStepsScreenRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

LogActivityRx logActivityRxObj = LogActivityRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


final GetRecentStepRx getRecentStepRxObj = GetRecentStepRx(
  empty: GetRecentStepModel(),
  dataFetcher: BehaviorSubject<GetRecentStepModel>(),
);

final GetAllFoodRx getAllFoodRxObj = GetAllFoodRx(
  empty: GetAllFoodModel(),
  dataFetcher: BehaviorSubject<GetAllFoodModel>(),
);

final GetRecentActivityLogRx getRecentActivityLogRx = GetRecentActivityLogRx(
  empty: GetRecentActivityModel(),
  dataFetcher: BehaviorSubject<GetRecentActivityModel>(),
);

final GetChatMessageRx getChatMessageRx = GetChatMessageRx(
  empty: AiChatHistoryDataModel(),
  dataFetcher: BehaviorSubject<AiChatHistoryDataModel>(),
);

DeleteMedicationRx deleteMedicationRxObj = DeleteMedicationRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

DeleteActivityRx deleteActivityRxObj = DeleteActivityRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

FoodScanPostRx foodScanPostRxObj = FoodScanPostRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

DeleteStepsRx deleteStepsRxObj = DeleteStepsRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

EditMedicationRx editMedicationRxObj = EditMedicationRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

FoodStoreRx foodStoreRxObj = FoodStoreRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


AddEquipmentsRx addEquipmentsRxObj = AddEquipmentsRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


SendMessageRx sendMessageRx = SendMessageRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(), chatHistoryRx: getChatMessageRx,
);



final GetAllEquipmentRx getAllEquipmentRxObj = GetAllEquipmentRx(
  empty: GetAllEquipmentModel(),
  dataFetcher: BehaviorSubject<GetAllEquipmentModel>(),
);


final GetRecentSleepRx getRecentSleepRx = GetRecentSleepRx(
  empty: GetAllSleepDataModel(),
  dataFetcher: BehaviorSubject<GetAllSleepDataModel>(),
);

PostLogOutRX postLogOutRXObj = PostLogOutRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


SaveSleepRx saveSleepRx = SaveSleepRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


DeleteSleepRx deleteSleepRx = DeleteSleepRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

StoreSupplementRx storeSupplementRx = StoreSupplementRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);