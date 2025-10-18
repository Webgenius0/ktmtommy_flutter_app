import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isChecked = true;
  bool get isChecked => _isChecked;
  String? _email;

  void toogleChecked(newValue) {
    // _isChecked = !_isChecked;
    _isChecked = newValue!;
    notifyListeners();
  }

  String _forgortMail = "";
  String _forgotToken = "";

  String get forgotMail => _forgortMail;
   String? get email => _email;
  String get forgotToken => _forgotToken;

  changForgotMail(String forgotMail) {
    _forgortMail = forgotMail;
  }
  changToken(String forgotMail) {
    _forgotToken = forgotMail;
  }

  bool _isObscure = true;
  // bool _isObscure2 = true;
  bool _isConfirmObscure = true;

  bool get isObscure => _isObscure;
  // bool get isObscure2 => _isObscure2;
  bool get isConfirmObscure => _isConfirmObscure;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  // void toggleObscure2() {
  //   _isObscure2 = !_isObscure2;
  //   notifyListeners();
  // }
  void toggleConfirmObscure() {
    _isConfirmObscure = !_isConfirmObscure;
    notifyListeners();
  }
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}