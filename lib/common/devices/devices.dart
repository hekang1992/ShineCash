import 'dart:io';
import 'package:flutter/services.dart';

class GetLanguageInfo {
  static final MethodChannel _channel = MethodChannel('shineapp_info');

  static Future<String> getLanguageMessage() async {
    try {
      final String version = await _channel.invokeMethod('getPlatformLanguage');
      return version;
    } on PlatformException catch (e) {
      return "Failed to get version: '${e.message}'.";
    }
  }
}

class ProxyEnabled {
  static String isProxyEnabled() {
    final env = Platform.environment;
    final useProxy =
        env.containsKey('http_proxy') || env.containsKey('HTTP_PROXY');
    return useProxy ? '1' : '0';
  }
}

class VpnEnabled {
  static final MethodChannel _channel = MethodChannel('shineapp_info');
  static Future<String> isVpnActive() async {
    try {
      final result = await _channel.invokeMethod('isVpnActive');
      return result ? '1' : '0';
    } catch (e) {
      return '0';
    }
  }
}
