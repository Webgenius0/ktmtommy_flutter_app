import 'dart:developer';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:flutter/services.dart';
import 'dart:io';

final class SubscriptionRx {
  String entitlementId = "Pro";

  final _isLoading = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isLoadingStream => _isLoading.stream;
  bool get isLoading => _isLoading.value;

  final _availablePackages = BehaviorSubject<List<Package>>.seeded([]);
  Stream<List<Package>> get availablePackagesStream =>
      _availablePackages.stream;
  List<Package> get availablePackages => _availablePackages.value;

  final _isPremium = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isPremiumStream => _isPremium.stream;
  bool get isPremium => _isPremium.value;

  // Selected plan index (-1 = none selected)
  final _selectedPlanIndex = BehaviorSubject<int>.seeded(-1);
  Stream<int> get selectedPlanIndexStream => _selectedPlanIndex.stream;
  int get selectedPlanIndex => _selectedPlanIndex.value;

  void selectPlan(int index) {
    _selectedPlanIndex.add(index);
  }

  // Stream to notify UI when offerings fetch fails
  final _fetchError = BehaviorSubject<String?>.seeded(null);
  Stream<String?> get fetchErrorStream => _fetchError.stream;
  String? get fetchError => _fetchError.value;

  SubscriptionRx() {
    init();
  }

  Future<void> init() async {
    try {
      bool isConfigured = await Purchases.isConfigured;
      if (!isConfigured) {
        log("⚙️ Configuring RevenueCat Purchases SDK...");
        if (Platform.isIOS) {
          await Purchases.configure(
            PurchasesConfiguration("appl_uURLmRnySbdTtUlOlLSfhcXADuY"),
          );
        } else if (Platform.isAndroid) {
          await Purchases.configure(
            PurchasesConfiguration("goog_YOUR_ANDROID_KEY"),
          );
        }
      }
    } catch (e) {
      log("❌ RevenueCat configuration error: $e");
    }
    await checkSubscriptionStatus();
    await fetchOfferings();
  }

  /// Retry fetching offerings — call this from UI when packages are empty
  Future<void> retryFetchOfferings() async {
    _fetchError.add(null);
    await fetchOfferings();
  }

  Future<void> fetchOfferings() async {
    try {
      _isLoading.add(true);
      _fetchError.add(null);

      final offerings = await Purchases.getOfferings();

      log("========== REVENUECAT ==========");
      log("All Offering Keys  : ${offerings.all.keys.toList()}");
      log("Current Offering   : ${offerings.current?.identifier}");

      if (offerings.current == null) {
        const msg = "No current offering found in RevenueCat dashboard.";
        log("❌ $msg");
        _fetchError.add(msg);
        return;
      }

      if (offerings.current!.availablePackages.isEmpty) {
        const msg = "Offering has no packages. Check App Store Connect products.";
        log("❌ $msg");
        _fetchError.add(msg);
        return;
      }

      for (final package in offerings.current!.availablePackages) {
        log("--------------------------------");
        log("Package Identifier : ${package.identifier}");
        log("Package Type       : ${package.packageType}");
        log("Store Product ID   : ${package.storeProduct.identifier}");
        log("Price              : ${package.storeProduct.priceString}");
      }

      _availablePackages.add(offerings.current!.availablePackages);

      log(
        "✅ Total Packages : ${offerings.current!.availablePackages.length}",
      );
    } on PlatformException catch (e) {
      log("❌ RevenueCat PlatformException");
      log("Message : ${e.message}");
      log("Details : ${e.details}");
      _fetchError.add(e.message ?? "RevenueCat error");
    } catch (e) {
      log("❌ fetchOfferings error: $e");
      _fetchError.add(e.toString());
    } finally {
      _isLoading.add(false);
    }
  }

  Package? _getPackageForIndex(int index) {
    log("Index = $index");
    log("Package Count = ${availablePackages.length}");

    if (availablePackages.isEmpty) {
      log("No packages available");
      return null;
    }

    switch (index) {
      case 0: // Weekly / Free Trial
        return availablePackages.firstWhere(
          (p) => p.packageType == PackageType.weekly,
          orElse: () => availablePackages.firstWhere(
            (p) => p.identifier.toLowerCase().contains('monthly'),
            orElse: () => availablePackages[0],
          ),
        );
      case 1: // Monthly / Plus Plan
        return availablePackages.firstWhere(
          (p) => p.packageType == PackageType.monthly,
          orElse: () => availablePackages.firstWhere(
            (p) => p.identifier.toLowerCase().contains('yearly'),
            orElse: () => availablePackages.length > 1
                ? availablePackages[1]
                : availablePackages[0],
          ),
        );
      case 2: // Yearly / Pro Plan
        return availablePackages.firstWhere(
          (p) => p.packageType == PackageType.annual,
          orElse: () => availablePackages.firstWhere(
            (p) =>
                p.identifier.toLowerCase().contains('annual') ||
                p.identifier.toLowerCase().contains('yearly') ||
                p.identifier.toLowerCase().contains('year'),
            orElse: () => availablePackages.length > 2
                ? availablePackages[2]
                : availablePackages[availablePackages.length - 1],
          ),
        );
      default:
        return null;
    }
  }

  /// Purchases a subscription package.
  ///
  /// If [planIndex] is provided it takes precedence; otherwise falls back to
  /// the currently selected plan index set via [selectPlan].
  Future<bool> purchaseSubscription({int? planIndex}) async {
    final resolvedPlanIndex = planIndex ?? selectedPlanIndex;

    log("Plan Index Passed: $resolvedPlanIndex");
    log("Available Packages Count: ${availablePackages.length}");

    for (final p in availablePackages) {
      log("Package: ${p.identifier}");
      log("Type: ${p.packageType}");
    }

    if (availablePackages.isEmpty) {
      ToastUtil.showShortToast("Packages not loaded yet. Please try again.");
      return false;
    }

    final package = _getPackageForIndex(resolvedPlanIndex);

    log("Selected Package: ${package?.identifier}");

    if (package == null) {
      ToastUtil.showShortToast("Package not found");
      return false;
    }

    _isLoading.add(true);

    try {
      log("Purchasing : ${package.identifier}");

      final result = await Purchases.purchase(
        PurchaseParams.package(package),
      );

      final customerInfo = result.customerInfo;

      log("========== PURCHASE RESULT ==========");

      customerInfo.entitlements.all.forEach((key, value) {
        log("$key -> ${value.isActive}");
      });

      final active =
          customerInfo.entitlements.all[entitlementId]?.isActive ?? false;

      if (active) {
        _isPremium.add(true);
        appData.write("isSubscribed", true);

        ToastUtil.showLongToast("Subscription Successful");

        return true;
      }

      ToastUtil.showShortToast(
        "Purchase completed but entitlement not active.",
      );

      return false;
    } on PlatformException catch (e) {
      log(e.message ?? "");
      log(e.details.toString());

      if (PurchasesErrorHelper.getErrorCode(e) !=
          PurchasesErrorCode.purchaseCancelledError) {
        ToastUtil.showShortToast(e.message ?? "Purchase failed");
      }

      return false;
    } finally {
      _isLoading.add(false);
    }
  }


  Future<void> checkSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();

      log("========== CUSTOMER INFO ==========");

      customerInfo.entitlements.all.forEach((key, value) {
        log("Entitlement : $key");
        log("Active      : ${value.isActive}");
      });

      bool active =
          customerInfo.entitlements.all[entitlementId]?.isActive ?? false;

      _isPremium.add(active);
      appData.write("isSubscribed", active);

      log("Subscription Status : ${active ? "PREMIUM" : "FREE"}");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> restorePurchases() async {
    _isLoading.add(true);
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      bool active =
          customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
      _isPremium.add(active);
      appData.write('isSubscribed', active);

      if (active) {
        ToastUtil.showLongToast("Purchases successfully restored.");
      } else {
        ToastUtil.showShortToast("No active subscriptions found to restore.");
      }
    } catch (e) {
      log("❌ Restore error: $e");
      ToastUtil.showShortToast("Failed to restore purchases");
    } finally {
      _isLoading.add(false);
    }
  }

  void dispose() {
    _isLoading.close();
    _availablePackages.close();
    _isPremium.close();
    _fetchError.close();
    _selectedPlanIndex.close();
  }
}
