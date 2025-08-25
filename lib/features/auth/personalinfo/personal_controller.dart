import 'package:flutter/widgets.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/features/base_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';

class PersonalController extends BaseController {
  late final String productID;
  final model = BaseModel().obs;
  List<TextEditingController> textControllers =
      []; // 存储所有的 TextEditingController

  var startTime = '';
  var endTime = '';

  @override
  void onInit() {
    super.onInit();
    productID = Get.arguments['productID'];
    findPersonalInfo(productID: productID);
    startTime = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

extension PersonalVc on PersonalController {
  findPersonalInfo({required String productID}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      Map<String, dynamic> dict = {'nodded': productID};
      final response = await http.post('/wzcnrht/fair', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        this.model.value = model;
        textControllers.clear();
        for (TemporaryModel element in model.expect?.temporary ?? []) {
          textControllers.add(TextEditingController());
        }
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  showPicker(
    List<CenturiesModel> modelArray,
    BuildContext context, {
    required void Function(String) cityBlock,
  }) {
    // 构造 Map<String, dynamic> 格式的数据
    Map<String, dynamic> pickerData = {};

    for (var province in modelArray) {
      Map<String, dynamic> cityMap = {};

      if (province.pens != null && province.pens!.isNotEmpty) {
        for (var city in province.centuries!) {
          List<String> districtList =
              city.centuries?.map((d) => d.pens ?? '').toList() ?? [''];
          cityMap[city.pens ?? ''] = districtList;
        }
      } else {
        cityMap[''] = [''];
      }

      pickerData[province.pens ?? ''] = cityMap;
    }

    Pickers.showMultiLinkPicker(
      context,
      data: pickerData,
      onCancel: (isCancel) {
        Future.delayed(Duration(microseconds: 200), () {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      onConfirm: (selected, index) {
        try {
          String provinceName = selected[0] ?? '';
          String cityName = selected[1] ?? '';
          String districtName = selected[2] ?? '';
          cityBlock('$provinceName|$cityName|$districtName');
        } catch (e) {
          print("failure====: $e");
        }
      },
      pickerStyle: PickerStyle(
        pickerItemHeight: 52.sp,
        pickerTitleHeight: 52.sp,
        backgroundColor: AppColor.whiteColor,
        menuHeight: 42.h,
        textColor: Color(0XFF7262EC),
        title: Align(
          child: Text(
            'Please select your city',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ),
        cancelButton: Padding(
          padding: EdgeInsets.only(left: 15.sp),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        commitButton: Padding(
          padding: EdgeInsets.only(right: 15.sp),
          child: Text(
            "Confirm",
            style: TextStyle(
              color: Color(0xFF7262EC),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      columeNum: 3,
    );
  }

  saveInfo(Map<String, dynamic> dict) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final response = await http.post('/wzcnrht/note', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        final homeVc = Get.find<HomeController>();
        homeVc.getProductDetaiPageInfo(productID: productID, type: '1');
        await PointTouchChannel.upLoadPoint(
          step: '5',
          startTime: startTime,
          endTime: DateTime.now().millisecondsSinceEpoch.toString(),
          orderID: '',
        );
      }
      ToastManager.showToast(model.captive ?? '');
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
