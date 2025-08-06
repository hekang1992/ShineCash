import 'package:get/get.dart';
import 'package:shinecash/common/http/http_request.dart';

class UpidfaController extends GetxController {
  final idfaParams = <String, String>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    debounce<Map<String, String>>(
      idfaParams,
      time: Duration(milliseconds: 1000),
      (value) {
        print('value---------$value');
        _postToServer(value);
      },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void setIDFAParams(Map<String, String> params) {
    idfaParams.value = params;
  }

  Future<void> _postToServer(Map<String, String> dict) async {
    final http = ShineHttpRequest();

    try {
      final respose = await http.post('/wzcnrht/nonsense', data: dict);
      print('respose---------${respose.data}');
    } catch (e) {
      print('response-failure: $e');
    }
  }
}
