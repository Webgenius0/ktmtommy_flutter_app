import 'package:ktmtommy_apps/features/auth/data/login_rx.dart';
import 'package:rxdart/subjects.dart';

LoginRx loginRxObj = LoginRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);
