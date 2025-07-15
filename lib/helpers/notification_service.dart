import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/networks/api_acess.dart';
import 'di.dart';

final class LocalNotificationService {
  LocalNotificationService._();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      locator<FirebaseMessaging>();

  static void initialize() {
    // initializationSettings  for Android
    if (Platform.isAndroid) {
      _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.getNotificationSettings();
    }
    // 1. This method only call when App is terminated(closed)
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          // FlutterAppBadger.updateBadgeCount(1);
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          // FlutterAppBadger.removeBadge();
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {},
    );

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((details) {
      {}
    }));
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "plix",
          "plixpushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.black,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['url'],
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> getToken() async {
    // For Ios
    if (Platform.isIOS) {
      log('Ios Device');
      // _firebaseMessaging.setAutoInitEnabled(true);

      // Get the APNS token
      _firebaseMessaging.getAPNSToken().then((apnsToken) {
        log('[APNS Token]: $apnsToken');
      });

      // Listen for token updates
      _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
        log('[FCM Token]: $fcmToken');
        sendToken(fcmToken); // Your token sending logic
      });
    }
    // FOR android
    else if (Platform.isAndroid) {
      log('android Device');
      _firebaseMessaging.getToken().then((token) async {
        log('[FCM]--> token: [ $token ]');
        await sendToken(token!);
      });

      _firebaseMessaging.onTokenRefresh.listen((token) async {
        log('[FCM]--> token: [ $token ]');
        log('[Device]--> token: [ ${appData.read(kKeyDeviceID)} ]');
        await sendToken(token);
      });
    }
  }

  static Future<void> sendToken(String token) async {
    try {
      final deviceToken = await appData.read(kKeyDeviceID);
      await postAddTokenRxObj
          .addToken({"token": token, "device_id": deviceToken});
      // postDeviceTokenRXobj.postDeviceToken(token: token);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> removeToken() async {
    try {
      _firebaseMessaging.deleteToken();
    } catch (error) {
      rethrow;
    }
  }
}
