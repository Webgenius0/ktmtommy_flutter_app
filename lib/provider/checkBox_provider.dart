// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckboxProvider extends ChangeNotifier {
  bool isCheck = true;
  void isChecks(bool value) {
    isCheck = value;
    notifyListeners();
  }
}
