import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/features/chat/presentation/chat_screen.dart';
import 'package:ktmtommy_apps/loading_screen.dart';
import 'package:provider/provider.dart';
import 'features/athlet_flow/athlet_section/auth/presentation/personal_information_sign_up_screen.dart';
import 'features/recovery_mood_section/auth/sign_up/presentation/sign_up_screen.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/register_provider.dart';
import 'networks/dio/dio.dart';
import 'networks/internet_checker/internet_checker_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(InternetController(), permanent: true);
  await GetStorage.init();
  diSetup();
  DioSingleton.instance.create();

  // EasyLoading setup
  configEasyLoading();

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

// ✅ EasyLoading Configuration Function
void configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return const UtillScreenMobile();
        },
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(
            // ✅ Here EasyLoading initialized
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context),
                child: widget!,
              );
            },
          ),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: Loading(),
          // home: PersonalInformationSignUpScreen(),
        );
      },
    );
  }
}
