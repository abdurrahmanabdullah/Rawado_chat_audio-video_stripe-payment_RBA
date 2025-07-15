// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
// import 'dart:io' show Platform;

// urlLunch(String url) {
//   if (Platform.isIOS) {
//     launch(url, forceSafariVC: false);
//   } else {
//     launch(url, forceWebView: false);
//   }
// }
 Future<void> openUrl(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    log(e.toString());
  }
}
