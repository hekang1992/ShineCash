import 'package:get/get.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/utils/google_market.dart';

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
    initLoginInfo();
  }

  Future<void> initLoginInfo() async {
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
}
