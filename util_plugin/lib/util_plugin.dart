import 'dart:async';

import 'package:flutter/services.dart';

class UtilPlugin {
  static const MethodChannel _channel = const MethodChannel('util_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<dynamic, dynamic>> get locale async {
    final version = await _channel.invokeMethod('locale') as Map<dynamic, dynamic>;
    return version;
  }

  static void setAppBadgeNumber(int badgeNumber) async {
    await _channel.invokeMethod('setAppBadgeNumber', {"badgeNumber": badgeNumber});
  }
}
