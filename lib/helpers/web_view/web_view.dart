
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';


class WebViewLink extends StatefulWidget {
  const WebViewLink({super.key, required this.link});

  final String link;

  @override
  State<WebViewLink> createState() => _WebViewLinkState();
}

class _WebViewLinkState extends State<WebViewLink> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track the loading state

  @override
  void initState() {
    super.initState();
    final url = widget.link;
    if (Uri.tryParse(url)?.hasAbsolutePath ?? false) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });

              log("Page finished loading: $url");

              if (url == 'https://alex.softvencefsd.xyz/api/stripe/success' ||
                  url.contains('https://alex.softvencefsd.xyz/api/stripe/success')) {
                log("✅ Stripe success detected in onPageFinished");
                if (mounted) {
                  NavigationService.navigateTo(Routes.navigationScreen);
                }
              } else if (url.contains('https://alex.softvencefsd.xyz/api/stripe/cancel')) {
                log("❌ Stripe cancel detected in onPageFinished");
                if (mounted) {
                  NavigationService.navigateTo(Routes.navigationScreen);
                }
              }
            },
            onNavigationRequest: (NavigationRequest request) {
              log('Navigating to: ${request.url}');
              if (request.url == 'https://alex.softvencefsd.xyz/stripe/success' ||
                  request.url.contains('https://alex.softvencefsd.xyz/stripe/success')) {
                log("✅ Stripe success detected in onNavigationRequest");
                if (mounted) {
                  NavigationService.navigateTo(Routes.navigationScreen);
                }
                return NavigationDecision.prevent;
              } else if (request.url.contains('https://alex.softvencefsd.xyz/stripe/cancel')) {
                log("❌ Stripe cancel detected in onNavigationRequest");
                if (mounted) {
                  NavigationService.navigateTo(Routes.navigationScreen);
                }
                return NavigationDecision.prevent;
              }

              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    } else {
      throw Exception("Invalid URL: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.c00AA4D,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Loading",
                        style: TextFontStyle.headline18w500cFFFFFF.copyWith(
                          color: AppColors.c00AA4D,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
