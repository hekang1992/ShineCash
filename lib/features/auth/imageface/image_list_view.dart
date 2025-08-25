import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/imageface/image_list_controller.dart';
import 'package:shinecash/features/auth/imageface/image_sheet_view.dart';
import 'package:shinecash/features/auth/imageface/image_success_list_view.dart';
import 'package:shinecash/features/auth/imageface/progress_list_view.dart';
import 'package:shinecash/features/home/home_controller.dart';

class ImageListView extends GetView<ImageListController> {
  ImageListView({super.key}) {
    final _ = Get.put(ImageListController());
    final _ = Get.put(CertificationListController());
  }

  @override
  Widget build(BuildContext context) {
    final cerVc = Get.find<CertificationListController>();
    final dict = controller.dict;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          color: AppColor.bgColor,
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SafeArea(
                child: AppHeadView(
                  title: 'Identity Authentication',
                  onTap: () async {
                    Get.back(result: 'refresh');
                    await cerVc.initAuthListInfo(dict['productID']);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.h,
                ),
                child: Column(
                  children: [
                    ProgressListView(pix: 0.2),
                    SizedBox(height: 15.h),
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Image.asset(
                          'assets/images/cycle_auth_image.png',
                          width: 37.w,
                          height: 23.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.sp),
                          child: Container(
                            width: 351.w,
                            height: 496.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.sp),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 24.sp),
                              child: Obx(() {
                                final model = controller.authlistModel.value;
                                final imageStr =
                                    model.expect?.rule?.cautiously ?? '';
                                final faceimageStr =
                                    model.expect?.posted?.cautiously ?? '';
                                return Column(
                                  children: [
                                    imageClickView(
                                      title: 'Upload ID Photos',
                                      imageStr: imageStr.isEmpty
                                          ? 'photo_imge.png'
                                          : imageStr,
                                      isClick:
                                          model.expect?.rule?.listening == 1
                                          ? false
                                          : true,
                                      onTap: () {
                                        controller.idStartTime = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                        Get.bottomSheet(
                                          isDismissible: false,
                                          enableDrag: false,
                                          ImageSheetView(
                                            imageStr: 'de_list_image.png',
                                            onTap: () async {
                                              Get.back();
                                              await Future.delayed(
                                                Duration(milliseconds: 250),
                                              );
                                              Get.bottomSheet(
                                                backgroundColor: Colors.white,
                                                isDismissible: false,
                                                enableDrag: false,
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.camera,
                                                      ),
                                                      title: Text('Camera'),
                                                      onTap: () async {
                                                        Get.back();

                                                        final originalData =
                                                            await ImageChannel.openCamera(
                                                              '0',
                                                            );
                                                        final model = await controller
                                                            .uploadImageWithType(
                                                              type: controller
                                                                  .dict['title'],
                                                              many: 11,
                                                              ink: 1,
                                                              originalData:
                                                                  originalData,
                                                            );
                                                        if (model == null) {
                                                          return;
                                                        }
                                                        Get.bottomSheet(
                                                          isDismissible: false,
                                                          enableDrag: false,
                                                          isScrollControlled:
                                                              true,
                                                          ImageSuccessListView(
                                                            model: model,
                                                            onTap: (controller) {
                                                              Get.back();
                                                              controller
                                                                      .oneVc
                                                                      .text =
                                                                  '';
                                                              controller
                                                                      .twoVc
                                                                      .text =
                                                                  '';
                                                              controller
                                                                      .threeVc
                                                                      .text =
                                                                  '';
                                                            },
                                                            sureTap: (controller) async {
                                                              await this.controller.saveTinInfo(
                                                                name: controller
                                                                    .oneVc
                                                                    .text,
                                                                id: controller
                                                                    .twoVc
                                                                    .text,
                                                                time: controller
                                                                    .threeVc
                                                                    .text,
                                                                many: '11',
                                                                read: this
                                                                    .controller
                                                                    .dict['title'],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }, // 返回1表示选择相机
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.photo_library,
                                                      ),
                                                      title: Text(
                                                        'Photo Gallery',
                                                      ),
                                                      onTap: () async {
                                                        Get.back();
                                                        final originalData =
                                                            await ImageChannel.openGallery();
                                                        final model = await controller
                                                            .uploadImageWithType(
                                                              type: controller
                                                                  .dict['title'],
                                                              many: 11,
                                                              ink: 2,
                                                              originalData:
                                                                  originalData,
                                                            );
                                                        if (model == null) {
                                                          return;
                                                        }
                                                        Get.bottomSheet(
                                                          isDismissible: false,
                                                          enableDrag: false,
                                                          isScrollControlled:
                                                              true,
                                                          ImageSuccessListView(
                                                            model: model,
                                                            onTap: (controller) {
                                                              Get.back();
                                                              controller
                                                                      .oneVc
                                                                      .text =
                                                                  '';
                                                              controller
                                                                      .twoVc
                                                                      .text =
                                                                  '';
                                                              controller
                                                                      .threeVc
                                                                      .text =
                                                                  '';
                                                            },
                                                            sureTap: (controller) async {
                                                              await this.controller.saveTinInfo(
                                                                name: controller
                                                                    .oneVc
                                                                    .text,
                                                                id: controller
                                                                    .twoVc
                                                                    .text,
                                                                time: controller
                                                                    .threeVc
                                                                    .text,
                                                                many: '11',
                                                                read: this
                                                                    .controller
                                                                    .dict['title'],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }, // 返回2表示选择相册
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.cancel,
                                                      ),
                                                      title: Text('Cancel'),
                                                      onTap: () => Get.back(
                                                        result: 0,
                                                      ), // 返回0表示取消
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 24.h),
                                    imageClickView(
                                      title: 'Facial Recognition',
                                      imageStr: faceimageStr.isEmpty
                                          ? 'face_image.png'
                                          : faceimageStr,
                                      isClick:
                                          model.expect?.posted?.listening == 1
                                          ? false
                                          : true,
                                      onTap: () {
                                        controller.faceStartTime =
                                            DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();
                                        Get.bottomSheet(
                                          isDismissible: false,
                                          enableDrag: false,
                                          ImageSheetView(
                                            imageStr: 'faca_de_image.png',
                                            onTap: () async {
                                              Get.back();
                                              await Future.delayed(
                                                Duration(milliseconds: 250),
                                              );
                                              final originalData =
                                                  await ImageChannel.openCamera(
                                                    '1',
                                                  );
                                              final model = await controller
                                                  .uploadImageWithType(
                                                    type:
                                                        controller
                                                            .authlistModel
                                                            .value
                                                            .expect
                                                            ?.rule
                                                            ?.read ??
                                                        '',
                                                    many: 10,
                                                    ink: 1,
                                                    originalData: originalData,
                                                  );
                                              if (model == null) {
                                                return;
                                              }
                                              final homeVc =
                                                  Get.find<HomeController>();
                                              homeVc.getProductDetaiPageInfo(
                                                productID: controller
                                                    .dict['productID'],
                                                type: '1',
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AppCommonFooterView(
                  title: 'Next',
                  onTap: () {
                    final model = controller.authlistModel.value;
                    final imageStr = model.expect?.rule?.cautiously ?? '';
                    final faceimageStr = model.expect?.posted?.cautiously ?? '';
                    if (imageStr.isEmpty) {
                      ToastManager.showToast(
                        'Please upload a photo of your ID first.',
                      );
                      return;
                    }
                    if (faceimageStr.isEmpty) {
                      ToastManager.showToast(
                        'Please upload a facial photo first.',
                      );
                      return;
                    }
                    final homeVc = Get.find<HomeController>();
                    homeVc.getProductDetaiPageInfo(
                      productID: controller.dict['productID'],
                      type: '1',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget imageClickView({
  required String title,
  required String imageStr,
  required VoidCallback onTap,
  required bool isClick,
}) {
  return InkWell(
    onTap: isClick ? onTap : null,
    child: Column(
      children: [
        if (imageStr.contains('http'))
          Image.network(
            imageStr,
            width: 264.w,
            height: 176.h,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator(
                color: Color(0XFF7262EC),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 264.w,
                height: 176.h,
                color: const Color.fromARGB(255, 216, 194, 239), // 红色背景
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 24.w,
                ),
              );
            },
          )
        else
          Image.asset(
            'assets/images/$imageStr',
            width: 264.w,
            height: 176.h,
            fit: BoxFit.fill,
          ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
