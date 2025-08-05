import 'package:hive_flutter/hive_flutter.dart';

class SaveLoginInfo {
  static const String _boxName = 'user_login_data_box';
  static const String _phoneKey = 'user_phone';
  static const String _tokenKey = 'user_token';
  static const String _netKey = 'user_network';

  static Box? _box;

  /// 开启存储用户信息盒子
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  /// 保存用户手机号
  static Future<void> savePhone(String phone) async {
    await _box?.put(_phoneKey, phone);
  }

  /// 获取用户手机号
  static String? getPhone() {
    return _box?.get(_phoneKey);
  }

  /// 保存用户 token
  static Future<void> saveToken(String token) async {
    await _box?.put(_tokenKey, token);
  }

  /// 获取用户 token
  static String? getToken() {
    return _box?.get(_tokenKey);
  }

  /// 保存用户 网络类型呢
  static Future<void> saveNetwork(String net) async {
    await _box?.put(_netKey, net);
  }

  /// 获取用户 网络类型
  static String? getNetwork() {
    return _box?.get(_netKey);
  }

  /// 检查是否已登录（是否有token）
  static bool isLogin() {
    return getToken() != null;
  }

  /// 清除所有用户数据
  static Future<void> clearAll() async {
    await _box?.clear();
  }

  /// 关闭 Hive 盒子（在应用退出时调用）
  static Future<void> close() async {
    await _box?.close();
  }
}
