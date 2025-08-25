import 'dart:convert';

import 'package:get/get.dart';
import 'package:shinecash/common/constants/deviceinfo.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/utils/app_location.dart';
import 'package:shinecash/common/utils/google_market.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class UpidfaController extends GetxController {
  final idfaParams = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    debounce<Map<String, String>>(
      idfaParams,
      time: Duration(milliseconds: 1000),
      (value) {
        _postToServer(value);
      },
    );
  }

  void setIDFAParams(Map<String, String> params) {
    idfaParams.value = params;
  }

  Future<void> _postToServer(Map<String, String> dict) async {
    try {
      final http = ShineHttpRequest();
      final respose = await http.post('/wzcnrht/nonsense', formData: dict);
      print('respose---------${respose.data}');
    } catch (e) {
      print('response-failure: $e');
    }

    await uploadlocation();
    await uploaddeviceInfo();
    await initLoginInfo();
  }

  initLoginInfo() async {
    try {
      final http = ShineHttpRequest();
      final delusion = await GetLanguageInfo.getLanguageMessage();
      final proudly = await VpnEnabled.isVpnActive();
      final feeling = ProxyEnabled.isProxyEnabled();
      final dict = {
        'delusion': delusion,
        'feeling': feeling,
        'proudly': proudly,
      };
      final response = await http.post('/wzcnrht/delusion', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        final alert = (model.expect?.driving ?? 0).toString();
        final kiss = model.expect?.kiss ?? '';
        SaveLoginInfo.saveAlert(alert);
        SaveLoginInfo.saveKiss(kiss);
        final fairModel = model.expect?.fair;
        final Map<String, String> fromJson = {
          'answers': fairModel?.answers ?? '',
          'crumpled': fairModel?.crumpled ?? '',
          'dirty': fairModel?.dirty ?? '',
          'taking': fairModel?.taking ?? '',
        };
        GoogleMarket.isVpnActive(fromJson);
      }
    } catch (e) {}
  }

  uploadlocation() async {
    try {
      final position = await AppLocation.getDetailedLocation();
      final http = ShineHttpRequest();
      final _ = await http.post('/wzcnrht/supposes', formData: position);
    } catch (e) {}
  }

  uploaddeviceInfo() async {
    try {
      final deviceInfoDict = await DeviceinfoManager.backDictAll();
      final deviceJsonStr = jsonEncode(deviceInfoDict);
      print('deviceJsonStr---------${jsonEncode(deviceInfoDict)}');
      final http = ShineHttpRequest();
      final dict = {'expect': deviceJsonStr};
      final _ = await http.post('/wzcnrht/concealment', formData: dict);
    } catch (e) {}
  }
}
