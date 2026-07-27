import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';


class SocialAuthApple {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<UserCredential?> signInWithApple(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String? identityToken = appleCredential.identityToken;
      final String? authorizationCode = appleCredential.authorizationCode;

      if (identityToken == null || identityToken.isEmpty) {
        debugPrint("❌ identityToken is null or empty. Aborting login.");
        ToastUtil.showLongToast("Apple login failed. Try again.");
        return null;
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: identityToken,
        accessToken: authorizationCode,
      );

      debugPrint("🆔 ID Token: $identityToken");
      debugPrint("🔑 Auth Code: $authorizationCode");

      // Firebase authentication
      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user != null) {
        // Extract full name and email if available
        final String? fullName = (appleCredential.givenName != null)
            ? "${appleCredential.givenName} ${appleCredential.familyName}"
            : user.displayName;

        final String? email = appleCredential.email ?? user.email;

        debugPrint("✅ Apple Login Success:");
        debugPrint("👤 Name: $fullName");
        debugPrint("📧 Email: $email");
        debugPrint("🆔 UID: ${user.uid}");
        debugPrint("🆔 Identity token is: ${identityToken}");

        // 🧪 Optional: Use UID or token for RevenueCat or backend
        debugPrint("📤 Sending login to API...");

        Map response = await postGoogleLoginRX.postGoogleLogin(
          token: identityToken,
          registerType: "apple",
        );

        log('Apple login response: ${postGoogleLoginRX.getSocialLoginRes.value}');

        if (response["success"] == true) {
          ToastUtil.showLongToast('Login Successfully');
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
          ToastUtil.showLongToast("Login failed. Please try again.");
        }

        return userCredential;
      } else {
        debugPrint("❌ Firebase User is null after Apple Sign-In.");
        ToastUtil.showLongToast("Login failed. Please try again.");
        return null;
      }
    } catch (e, stack) {
      debugPrint("❌ Apple Sign-In Error: $e");
      log("Apple Sign-In Exception", error: e, stackTrace: stack);
      ToastUtil.showLongToast("An error occurred during login.");
      return null;
    }
  }
}