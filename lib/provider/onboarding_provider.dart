

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  bool isFirstTime = true;

 // constructor
  OnboardingProvider() {
    loadOnboardingStatus();;
  }

  Future<void> loadOnboardingStatus() async{
    final prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('isFirstTime') ?? true;
    notifyListeners();
  }


  Future<void> completeOnboarding () async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
     isFirstTime = false;
    notifyListeners();
  }

}
