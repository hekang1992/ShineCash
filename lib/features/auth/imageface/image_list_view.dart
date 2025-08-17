import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/imageface/image_list_controller.dart';
import 'package:shinecash/features/auth/imageface/image_sheet_view.dart';
import 'package:shinecash/features/auth/imageface/progress_list_view.dart';

class ImageListView extends GetView<ImageListController> {
  ImageListView({super.key}) {
    final _ = Get.put(ImageListController());
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
                    ProgressListView(pix: 0.25),
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
                              child: Column(
                                children: [
                                  imageClickView(
                                    title: 'Upload ID Photos',
                                    imageStr: 'photo_imge.png',
                                    onTap: () {
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.camera),
                                                    title: Text('Camera'),
                                                    onTap: () async {
                                                      Get.back();
                                                      final originalData =
                                                          await ImageChannel.openCamera(
                                                            '0',
                                                          );
                                                      await controller
                                                          .uploadImageWithType(
                                                            type: controller
                                                                .dict['title'],
                                                            many: 11,
                                                            ink: 1,
                                                            originalData:
                                                                originalData,
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
                                                      await controller
                                                          .uploadImageWithType(
                                                            type: controller
                                                                .dict['title'],
                                                            many: 11,
                                                            ink: 2,
                                                            originalData:
                                                                originalData,
                                                          );
                                                    }, // 返回2表示选择相册
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.cancel),
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
                                    imageStr: 'face_image.png',
                                    onTap: () {
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
                                                    onTap: () {
                                                      Get.back(); // 返回1表示选择相机
                                                      ImageChannel.openCamera(
                                                        '1',
                                                      );
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.cancel),
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
                                ],
                              ),
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
                child: AppCommonFooterView(title: 'Next'),
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
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset('assets/images/$imageStr', width: 264.w, height: 176.h),
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
