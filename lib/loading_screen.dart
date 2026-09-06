
import 'package:flutter/material.dart';
import 'package:ktmtommy_apps/athlet_bottom_navigation_bar.dart';
import 'package:ktmtommy_apps/bottom_nav_screen.dart';
import 'package:ktmtommy_apps/features/auth/presentation/login_screen_athlet.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/onboarding_screen.dart';
import 'package:ktmtommy_apps/splash_screen.dart';
import 'constants/app_constants.dart';
import 'features/log_in_selection_mode/log_in_selection_mode_screen.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/notification/notification_service.dart';
import 'networks/dio/dio.dart';



final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = false;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }
  ///======================== Original loadInitialData =======================///
  // loadInitialData() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   await setInitValue();
  //
  //   bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
  //   bool firstTime = appData.read(kKeyIsFirstTime)?? false;
  //    if (isLoggedIn) {
  //     String token = appData.read(kKeyAccessToken);
  //     DioSingleton.instance.update(token);
  //     Navigator.pushReplacement( context ,
  //       MaterialPageRoute(builder: (context) => BottomNavScreen()),
  //     );
  //   }
  //    else if (firstTime) {
  //   Navigator.pushReplacement( context ,
  //   MaterialPageRoute(builder: (context) => OnboardingScreen()),
  //   );
  //   }else {
  //     // Navigate to LoginScreen if not logged in
  //     NavigationService.navigateToReplacement(Routes.logInSelectionModeScreen);
  //   }
  //
  //   setState(() {
  //   });
  // }
  ///======================== Updated loadInitialData =======================///
  loadInitialData() async {
    await Future.delayed(const Duration(seconds: 2));
    await setInitValue();

    bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
    bool isFirstTime = appData.read(kKeyIsFirstTime) ?? true; // first tme default true

    if (!isFirstTime && isLoggedIn) {
      // User already log in  +  not first time + derected to their respective home screens
      String? userMode = appData.read(kKeyUserType); // "recovery" and "athlete"
      String token = appData.read(kKeyAccessToken) ?? "";

      // Token Update Dio
      DioSingleton.instance.update(token);
      NotificationService.sendFcmTokenToServer();

      if (userMode == "athlete") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  AthletBottomNavigationBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  BottomNavScreen()),
        );
      }
    }
    else if (isFirstTime) {
      /// First time user → Onboarding Screen then mood selection screen
      appData.write(kKeyIsFirstTime, false); // Set first time to false after first launch
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
    else {
      ///====== Not first time + not logged in → log in selection screen ======///
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenAthlet()),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();
    } else {
      return appData.read(kKeyIsFirstTime)
          ? OnboardingScreen ()
          : const LoginScreenAthlet();
    }
    
  }
}