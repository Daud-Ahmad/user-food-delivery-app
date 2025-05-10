import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';
import '../../network/api_client.dart';
import '../../preferences.dart';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashViewModel extends BaseViewModel {

  Future onStartup(BuildContext context) async {
    ApiClient.create(context);
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return Future.delayed(const Duration(seconds: 3), () async {
      final token = await Preferences.getKey(Preferences.kToken);
      final userId = await Preferences.getKey(Preferences.kUserId);
      final isUserAsGuest = await Preferences.getKey(Preferences.kIsUserAsGuest);

      if ((token == null || token.isEmpty) && (isUserAsGuest == null || isUserAsGuest.isEmpty)) {
        Navigator.pushReplacementNamed(context, '/login_screen');
        return;
      }
      ApiClient.setAuthToken(token);
      Navigator.pushReplacementNamed(context, '/home_screen', arguments: 0);
    });
  }

   initState() {
    final android =
    AndroidInitializationSettings('@drawable/ic_notifications_icon');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin!
        .initialize(initSettings, onSelectNotification: onSelectNotification);

    setupInteractedMessage();

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                priority: Priority.high,
                importance: Importance.max,
                setAsGroupSummary: true,
                styleInformation: DefaultStyleInformation(true, true),
                largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                channelShowBadge: true,
                autoCancel: true,
                icon: '@drawable/ic_notifications_icon',
              ),
            ),
            payload: action);
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
  }

  Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => _handleMessage(value != null ? value.data : Map()));
  }

  void _handleMessage(Map<String, dynamic> data) {

  }
}
