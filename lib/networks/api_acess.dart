import 'package:ktmtommy_apps/features/auth/data/login_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/delete_medication_data/delete_medication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/edit_medication_data/edit_madication_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/log_tablet_screen_store_data/store_rx.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/registration_data/registration_rx.dart';
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




///==================                  ======================== ///
StoreRx storeRxObj = StoreRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

DeleteMedicationRx deleteMedicationRxObj = DeleteMedicationRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

EditMedicationRx editMedicationRxObj = EditMedicationRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);