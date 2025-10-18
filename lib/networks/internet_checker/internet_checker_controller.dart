import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'internet_checher_popup.dart';


class InternetController extends GetxController {
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> resultList) {
      if (resultList.isNotEmpty) {
        internetStatus(resultList.first);
      } else {
        internetStatus(ConnectivityResult.none);
      }
    });
  }

  void internetStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!Get.isSnackbarOpen) {
          InternetConnectionPopup(Get.context!, retryConnection);
        }
      });
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  void retryConnection() {
    connectivity.checkConnectivity().then((resultList) {
      if (resultList.isNotEmpty) {
        internetStatus(resultList.first);
      } else {
        internetStatus(ConnectivityResult.none);
      }
    });
  }
}
