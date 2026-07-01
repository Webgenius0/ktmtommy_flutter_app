import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:s_castor_flutter/networks/api_acess.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/toast.dart';


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

        await postGoogleLoginRX.postGoogleLogin(
          token: identityToken,
          registerType: "apple",
        );

        log('Apple login response: ${postGoogleLoginRX.getSocialLoginRes.value}');

        // Navigate to home
       NavigationService.navigateToUntilReplacement(Routes.bottomNavScreen);
        ToastUtil.showLongToast('Login Successfully');

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