import 'package:hive_flutter/hive_flutter.dart';

class SaveLoginInfo {
  static const String _boxName = 'user_login_data_box';
  static const String _phoneKey = 'user_phone';
  static const String _tokenKey = 'user_token';
  static const String _netKey = 'user_network';
  static const String _showAlert = 'user_showAlert';
  static const String _kiss = 'user_kiss';
  static const String _deineLoacation = 'user_deineLoacation';
  static const String _apiurl = 'user_api_url';

  static const String _lat = 'user_lat';
  static const String _lon = 'user_lon';

  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  static Future<void> savePhone(String phone) async {
    await _box?.put(_phoneKey, phone);
  }

  static String? getPhone() {
    return _box?.get(_phoneKey);
  }

  static Future<void> saveToken(String token) async {
    await _box?.put(_tokenKey, token);
  }

  static String? getToken() {
    return _box?.get(_tokenKey);
  }

  static Future<void> saveNetwork(String net) async {
    await _box?.put(_netKey, net);
  }

  static String? getNetwork() {
    return _box?.get(_netKey);
  }

  static Future<void> saveAlert(String alert) async {
    await _box?.put(_showAlert, alert);
  }

  static String? getAlert() {
    return _box?.get(_showAlert);
  }

  static Future<void> saveKiss(String kiss) async {
    await _box?.put(_kiss, kiss);
  }

  static String? getKiss() {
    return _box?.get(_kiss);
  }

  static Future<void> saveLocationTime(String location) async {
    await _box?.put(_deineLoacation, location);
  }

  static String? getLocationTime() {
    return _box?.get(_deineLoacation);
  }

  static Future<void> saveApiUrl(String url) async {
    await _box?.put(_apiurl, url);
  }

  static Future<void> saveLat(String lat) async {
    await _box?.put(_lat, lat);
  }

  static String? getLat() {
    return _box?.get(_lat);
  }

  static Future<void> saveLon(String lon) async {
    await _box?.put(_lon, lon);
  }

  static String? getLon() {
    return _box?.get(_lon);
  }

  static String? getApiUrl() {
    return _box?.get(_apiurl);
  }

  static bool isLogin() {
    return getToken() != null;
  }

  static Future<void> clearAll() async {
    await _box?.clear();
  }

  static Future<void> close() async {
    await _box?.close();
  }
}
