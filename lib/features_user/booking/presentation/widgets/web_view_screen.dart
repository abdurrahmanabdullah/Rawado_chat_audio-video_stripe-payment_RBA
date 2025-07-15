import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../provider/booking_porvider.dart';

class WebViewScreen extends StatefulWidget {
  final String link;
  const WebViewScreen({super.key, required this.link});

  @override
  State<WebViewScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    log('payment link >>>>>> ----- ${widget.link}');
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            log('------------------------Page started loading: $url');
          },
          onPageFinished: (String url) {
            log('------------------------Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            log('------------------------${error.response?.statusCode}}');
            log('------------------------error message ${error.request?.uri.data}}');
          },
          onWebResourceError: (WebResourceError error) {
            log('------------------------error resourse error $error}');
          },
          onUrlChange: (change) {
            log('------------------------onUrlChange to: ${change.url}');
          },
          onNavigationRequest: (NavigationRequest request) {
            log('------------------------>>>>Navigating to: ${request.url}');
            if (request.url.contains('paymentBack')) {
              // Payment succeeded, navigate to another screen
              // Clear The Booking Information
              Provider.of<BookingPorvider>(context, listen: false)
                  .clearBookingInfo();
              //Show Payment Sucess Status
              Get.snackbar('Sussess', 'Payment Success',
                  backgroundColor: Colors.green[300],
                  snackPosition: SnackPosition.BOTTOM);

              NavigationService.navigateTo(Routes.navigationScreen);

              // Show The Pop UP
              // getPopUp(context, (p0) {
              //   return PaymentSuccessfulWidget(
              //     onTap: () {
              //       NavigationService.navigateTo(Routes.navigationScreen);
              //     },
              //     imagePath: Assets.images.verifyImage.path,
              //     title: 'YOU BOOKING CREATE SUCCESSFULLY',
              //     subTitle: 'TRAINER WILL COMPLETED SERVICE IN SCHEDULE TIME.',
              //   );
              // });

              return NavigationDecision
                  .prevent; // Prevent further WebView navigation
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..currentUrl()
      ..loadRequest(Uri.parse(widget.link));

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PAYMENT',
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
