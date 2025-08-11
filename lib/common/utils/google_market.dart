import 'package:flutter/services.dart';

class GoogleMarket {
  static final MethodChannel _channel = MethodChannel('shineapp_info');
  static Future<void> isVpnActive(Map<String, String> fromJson) async {
    try {
      await _channel.invokeMethod('googleMarket', fromJson);
    } catch (e) {}
  }
}
