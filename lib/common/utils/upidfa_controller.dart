import 'package:get/get.dart';
import 'package:shinecash/common/http/http_request.dart';

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
  }
}
