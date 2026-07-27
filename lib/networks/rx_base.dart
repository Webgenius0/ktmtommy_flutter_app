import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';
import 'package:rxdart/subjects.dart';

abstract class RxResponseInt<T> {
  T empty;
  BehaviorSubject<T> dataFetcher;
  Map? map;
  BehaviorSubject? dataFetcher2;

  RxResponseInt(
      {required this.empty,
      required this.dataFetcher,
      this.map,
      this.dataFetcher2});

  dynamic handleSuccessWithReturn(T data) {
    dataFetcher.sink.add(data);
    return data;
  }

  dynamic handleErrorWithReturn(dynamic error) {
    log(error.toString());

    int? statusCode;
    if (error is DioException) {
      statusCode = error.response?.statusCode;
    } else if (error is Failure) {
      statusCode = error.resonseCode;
    } else {
      try {
        statusCode = error.response?.statusCode;
      } catch (_) {}
    }

    if (statusCode == 401) {
      // NavigationService.navigateToUntilReplacement(Routes.login);
    }

    dataFetcher.sink.addError(error);
    throw error;
  }

  void clean() {
    dataFetcher.sink.add(empty);
  }

  void dispose() {
    dataFetcher.close();
  }
}
