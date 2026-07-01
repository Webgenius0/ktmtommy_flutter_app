import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:s_castor_flutter/helpers/all_routes.dart';
import 'package:s_castor_flutter/helpers/navigation_service.dart';
import 'package:s_castor_flutter/helpers/toast.dart';
import 'package:s_castor_flutter/networks/api_acess.dart';

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
        await postGoogleLoginRX.postGoogleLogin(
          token: credential.accessToken.toString(),
          registerType: "google",
        );

        ToastUtil.showLongToast('Login Successful ✅');

        // 🔹 Navigate to bottom navigation page
        NavigationService.navigateToUntilReplacement(
          Routes.bottomNavScreen,         );
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