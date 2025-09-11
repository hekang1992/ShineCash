import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/auth/imageface/image_sheet_view.dart';
import 'package:shinecash/features/auth/imageface/image_success_list_view.dart';
import 'package:shinecash/features/home/home_controller.dart';

class ImageListController extends GetxController {
  late final Map<String, dynamic> dict;

  final authlistModel = BaseModel().obs;

  var idStartTime = '';
  var faceStartTime = '';

  var imageUploadBool = false;

  @override
  void onInit() async {
    super.onInit();
    dict = Get.arguments;
    print('dict--------$dict');
    await judgeMentThat(productID: dict['productID'], type: '1');
    final imageStr = authlistModel.value.expect?.rule?.cautiously ?? '';
    final faceimageStr = authlistModel.value.expect?.posted?.cautiously ?? '';
    if (imageStr.isEmpty) {
      imageClick();
    } else if (faceimageStr.isEmpty) {
      faceClick();
    }
  }
}

extension ImageListVc on ImageListController {
  judgeMentThat({required String productID, required String type}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final dict = {'nodded': productID};
      final response = await http.post('wzcnrht/enemy', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        authlistModel.value = model;
        final rule = model.expect?.rule;
        final posted = model.expect?.rule;
        if (rule?.listening == 1 || posted?.listening == 1) {
        } else if (rule?.listening == 0) {
        } else {}
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  Future<BaseModel?> uploadImageWithType({
    required String type,
    required int many,
    required int ink,
    required Uint8List originalData,
  }) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final dict = {'read': type, 'many': many, 'ink': ink};
      final response = await http.uploadImage(
        'wzcnrht/driving',
        originalData: originalData,
        extraData: dict,
      );
      final model = BaseModel.fromJson(response.data);
      ToastManager.showToast(model.captive ?? '');
      ToastManager.hideLoading();
      if (model.beautiful == '0' || model.beautiful == '00') {
        if (many == 10) {
          await PointTouchChannel.upLoadPoint(
            step: '4',
            startTime: faceStartTime,
            endTime: (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
            orderID: '',
          );
        }
        return model;
      }
    } catch (e) {
      ToastManager.hideLoading();
    }
    return null;
  }

  saveTinInfo({
    required String name,
    required String id,
    required String time,
    required String many,
    required String read,
  }) async {
    try {
      final http = ShineHttpRequest();
      ToastManager.showLoading();
      final dict1 = {
        'requests': time,
        'supplied': id,
        'pens': name,
        'many': many,
        'read': read,
      };
      final response = await http.post('wzcnrht/kiss', formData: dict1);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        Get.back();
        judgeMentThat(productID: dict['productID'], type: '1');
        if (many == '11') {
          await PointTouchChannel.upLoadPoint(
            step: '3',
            startTime: idStartTime,
            endTime: (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
            orderID: '',
          );
        }
      }
      ToastManager.showToast(model.captive ?? '');
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  faceClick() {
    faceStartTime = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    Get.bottomSheet(
      isDismissible: false,
      enableDrag: false,
      ImageSheetView(
        imageStr: 'faca_de_image.png',
        onTap: () async {
          Get.back();
          await Future.delayed(Duration(milliseconds: 250));
          final originalData = await ImageChannel.openCamera('1');
          final model = await uploadImageWithType(
            type: authlistModel.value.expect?.rule?.read ?? '',
            many: 10,
            ink: 1,
            originalData: originalData,
          );
          if (model == null) {
            return;
          }
          final homeVc = Get.find<HomeController>();
          homeVc.getProductDetaiPageInfo(
            productID: dict['productID'],
            type: '1',
            inner: '1',
          );
        },
      ),
    );
  }

  imageClick() {
    idStartTime = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    Get.bottomSheet(
      isDismissible: false,
      enableDrag: false,
      ImageSheetView(
        imageStr: 'de_list_image.png',
        onTap: () async {
          Get.back();
          await Future.delayed(Duration(milliseconds: 250));
          Get.bottomSheet(
            backgroundColor: Colors.white,
            isDismissible: false,
            enableDrag: false,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                  onTap: () async {
                    Get.back();

                    final originalData = await ImageChannel.openCamera('0');
                    final model = await uploadImageWithType(
                      type: dict['title'],
                      many: 11,
                      ink: 1,
                      originalData: originalData,
                    );
                    if (model == null) {
                      return;
                    }
                    Get.bottomSheet(
                      isDismissible: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      ImageSuccessListView(
                        model: model,
                        onTap: (controller) {
                          Get.back();
                          controller.oneVc.text = '';
                          controller.twoVc.text = '';
                          controller.threeVc.text = '';
                        },
                        sureTap: (controller) async {
                          await saveTinInfo(
                            name: controller.oneVc.text,
                            id: controller.twoVc.text,
                            time: controller.threeVc.text,
                            many: '11',
                            read: dict['title'],
                          );
                        },
                      ),
                    );
                  }, // 返回1表示选择相机
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Gallery'),
                  onTap: () async {
                    Get.back();
                    final originalData = await ImageChannel.openGallery();
                    final model = await uploadImageWithType(
                      type: dict['title'],
                      many: 11,
                      ink: 2,
                      originalData: originalData,
                    );
                    if (model == null) {
                      return;
                    }
                    Get.bottomSheet(
                      isDismissible: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      ImageSuccessListView(
                        model: model,
                        onTap: (controller) {
                          Get.back();
                          controller.oneVc.text = '';
                          controller.twoVc.text = '';
                          controller.threeVc.text = '';
                        },
                        sureTap: (controller) async {
                          await saveTinInfo(
                            name: controller.oneVc.text,
                            id: controller.twoVc.text,
                            time: controller.threeVc.text,
                            many: '11',
                            read: dict['title'],
                          );
                        },
                      ),
                    );
                  }, // 返回2表示选择相册
                ),
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text('Cancel'),
                  onTap: () => Get.back(result: 0), // 返回0表示取消
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
