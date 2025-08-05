import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:core';

class NetworkMonitoring {
  static final Connectivity _connectivity = Connectivity();

  // 检查当前网络（返回布尔值）
  static Future<bool> isConnected() async {
    List<ConnectivityResult> results = await _connectivity.checkConnectivity();
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    return result != ConnectivityResult.none;
  }

  // 监听网络变化（返回Stream<ConnectivityResult>）
  static Stream<List<ConnectivityResult>> get onNetworkChanged {
    return _connectivity.onConnectivityChanged;
  }

  // 可选：获取详细网络类型名称
  static Future<String> getNetworkType() async {
    final result = await _connectivity.checkConnectivity();
    return result.toString().split('.').last; // 例如返回 "wifi"、"mobile"
  }
}
