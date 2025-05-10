import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Preferences {
  static const String kToken = 'Token';
  static const String kUserId = 'user-id';
  static const String kUserName = 'user-name';
  static const String kUserEmail = 'user-email';
  static const String kUserPhone = 'user-phone';
  static const String kIsUserAsGuest = 'kIsUserAsGuest';
  static const String kCart = 'kCart';
  static const String kDeliveryFee = 'kDeliveryFee';


  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future setKey(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> getKey(String key) async {

    if(Platform.isIOS){
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('first_run') ?? true) {
        await storage.deleteAll();
        prefs.setBool('first_run', false);
      }
    }

    return await storage.read(key: key);
  }
}
