import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';

class GoogleAuthData {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // 🔹 Step 1: Start Google Sign-in flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // 🔹 If user pressed "back" or cancelled login
      if (googleSignInAccount == null) {
        ToastUtil.showShortToast('Google sign-in cancelled');
        return null;
      }

      // 🔹 Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 🔹 Step 2: Get authentication details
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // 🔹 Step 3: Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      log('🎟️ Access token: ${credential.accessToken}');

      // 🔹 Step 4: Sign in to Firebase
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      // Close loading dialog safely
      if (Navigator.canPop(context)) Navigator.pop(context);

      // 🔹 Step 5: If user is authenticated
      if (authResult.user != null) {
        log('✅ Firebase Auth successful: ${authResult.user!.email}');


        ///>>>>>>>>>>>>>. here is api calling >>>>>>>>>>>>>>>>>>


        // 🔹 Send token to your backend API
        Map response = await postGoogleLoginRX.postGoogleLogin(
          token: credential.accessToken.toString(),
          registerType: "google",
        );

        if (response["success"] == true) {
          ToastUtil.showLongToast('Login Successful ✅');
          final data = response["data"] ?? {};
          final bool onboardingCompleted = data["onboarding_completed"] ?? false;
          final String? userMode = data["user_mode"];

          if (!onboardingCompleted) {
            if (userMode == "recovery") {
              await appData.write(kKeyUserType, "recovery");
              NavigationService.navigateToUntilReplacement(Routes.tellUsAboutScreen);
            } else if (userMode == "athlete") {
              await appData.write(kKeyUserType, "athlete");
              NavigationService.navigateToUntilReplacement(Routes.welcomeAtheleteScreen);
            } else {
              NavigationService.navigateToUntilReplacement(Routes.chooseModeScreen);
            }
          } else {
            if (userMode != null) {
              await appData.write(kKeyUserType, userMode);
            }
            if (userMode == "athlete") {
              NavigationService.navigateToUntilReplacement(Routes.athletBottomNavigationBar);
            } else {
              NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
            }
          }
        } else {
          signOut();
          ToastUtil.showShortToast('Login failed. Please try again.');
        }
      } else {
        signOut();
        ToastUtil.showShortToast('Login failed. Try again.');
      }

      log("Google sign-in complete: ${authResult.user}");
      return authResult.user;
    } catch (error, stack) {
      log("❌ Google Sign-in error: $error");
      log(stack.toString());
      signOut();
      // Close loading dialog if open
      if (Navigator.canPop(context)) Navigator.pop(context);

      // Show readable error message
      ToastUtil.showShortToast("Sign-in failed. Please try again.");
      return null;
    }
  }

  /// Optional helper to logout cleanly
  static Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    log('👋 User signed out from Google');
  }





}