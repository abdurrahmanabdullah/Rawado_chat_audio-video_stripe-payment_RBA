// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../provider/address_provider.dart';
import '/helpers/di.dart';
import '/helpers/toast.dart';
import '../common_wigdets/custom_button.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

//final appData = locator.get<GetStorage>();
// final plcaeMarkAddress = locator.get<PlcaeMarkAddress>();
//declared for cart scrren calling bottom shit with this from reorder rx
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<PopupMenuButtonState<String>> popUpGlobalkey =
    GlobalKey<PopupMenuButtonState<String>>();

String language(String languageKey) {
  late String language;

  switch (languageKey) {
    case kKeyEnglish:
      language = "English";
      break;
    case kKeyFrench:
      language = "Arabic";
      break;
  }
  return language;
}

String dateName(String day) {
  late String name;
  switch (day) {
    case 'saturday':
      name = "SAT";
      break;
    case 'sunday':
      name = "SUN";
      break;
    case 'monday':
      name = "MON";
      break;
    case 'tuesday':
      name = "TUES";
      break;
    case 'wednesday':
      name = "WED";
      break;
    case 'thursday':
      name = "THU";
      break;
    case 'friday':
      name = "FRI";
      break;

    default:
      name = "";
      break;
  }
  return name;
}

Color appColor() {
  late Color appPrimaryColor;
  switch (appData.read(kKeyTheam)) {
    case kKeyPurpleTheam:
      appPrimaryColor = AppColors.allPrimaryColor;
      break;
    case kKeyWhiteTheam:
      appPrimaryColor = AppColors.whiteTheamColor;
      break;
    case kKeyBlueTheam:
      appPrimaryColor = AppColors.blueTheamColor;
      break;
  }
  return appPrimaryColor;
}

Color appTextColor() {
  late Color appTextColor;
  switch (appData.read(kKeyTheam)) {
    case kKeyPurpleTheam:
      appTextColor = AppColors.white;
      break;
    case kKeyWhiteTheam:
      appTextColor = AppColors.c222222;
      break;
    case kKeyBlueTheam:
      appTextColor = AppColors.c222222;
      break;
  }
  return appTextColor;
}

Future<String?> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;

  // ignore: unnecessary_null_comparison
  return (bytes != null ? base64Encode(bytes) : null);
}

Future<void> setInitValue() async {
  await appData.writeIfNull(kKeyIsLoggedIn, false);
  await appData.writeIfNull(kKeyIsExploring, false);
  await appData.writeIfNull(kKeyIsFirstTime, true);
  await appData.writeIfNull(kKeyTheam, kKeyPurpleTheam);
  appData.writeIfNull(kKeyLanguage, kKeyPortuguese);
  appData.writeIfNull(kKeyCountryCode, countriesCode[kKeyPortuguese]);
  appData.writeIfNull(kKeySelectedLocation, false);

  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    appData.writeIfNull(
        kKeyDeviceID, iosDeviceInfo.identifierForVendor); // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo =
        await deviceInfo.androidInfo; // unique ID on Android
    appData.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  }
  await Future.delayed(const Duration(seconds: 2));
}

Future<void> initiInternetChecker() async {
  InternetConnectionChecker.createInstance(
          // checkTimeout: const Duration(seconds: 1),
          checkInterval: const Duration(seconds: 2))
      .onStatusChange
      .listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        ToastUtil.showShortToast('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        ToastUtil.showNoInternetToast();
        break;
    }
  });
}

Completer<T> wrapInCompleter<T>(Future<T> future) {
  final completer = Completer<T>();
  future.then(completer.complete).catchError(completer.completeError);
  return completer;
}

Future<void> getInvisible() async {
  Future.delayed(const Duration(milliseconds: 500), () {});
}

Future<File> getLocalFile(String filename) async {
  File f = File(filename);
  return f;
}

void showMaterialDialog(
  BuildContext context,
) {
  showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Do you want to exit the app?",
              textAlign: TextAlign.center,
              style: TextFontStyle.headline14StyleMontserrat
                  .copyWith(color: AppColors.c222222),
            ),
            actions: <Widget>[
              customButton(
                  name: "No".tr,
                  onCallBack: () {
                    Navigator.of(context).pop(false);
                  },
                  height: 30.sp,
                  minWidth: .3.sw,
                  borderRadius: 30.r,
                  color: AppColors.cFEFFFE,
                  textStyle: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      color: appColor(),
                      fontWeight: FontWeight.w700),
                  context: context),
              customButton(
                  name: "Yes".tr,
                  onCallBack: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  height: 30.sp,
                  minWidth: .3.sw,
                  borderRadius: 30.r,
                  color: appColor(),
                  textStyle: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  context: context),
            ],
          ));
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void getPopUp(
  BuildContext context,
  Widget Function(BuildContext) childBuilder,
) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent, child: childBuilder(context));
      });
}

// Location Get

Future<String> getAddressFromLatLng(double lat, double lng) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  Placemark place = placemarks[0];
  log("my place1 : ${placemarks[0]}");
  log("my place1 : ${placemarks[1]}");
  log("my place1 : ${placemarks[2]}");
  return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

  //'${place.name}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
}

Future<String> getCurrentAddressFromLatLng(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Handle the case where permission is denied
      // You can show an alert dialog or a snackbar here
      // return;
    }
  }

  Position position = await Geolocator.getCurrentPosition();

  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemarks[0];
  log("address response : $place");
  String address =
      "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //'${place.name}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  Provider.of<AddressProvider>(context, listen: false).setAddress(
      address, position.latitude.toString(), position.longitude.toString());
  return address;
}
