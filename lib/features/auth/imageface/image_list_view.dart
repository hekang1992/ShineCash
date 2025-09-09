import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/certificationlist/leave_view.dart';
import 'package:shinecash/features/auth/imageface/image_list_controller.dart';
import 'package:shinecash/features/auth/imageface/progress_list_view.dart';

class ImageListView extends GetView<ImageListController> {
  ImageListView({super.key}) {
    final _ = Get.put(ImageListController());
    final _ = Get.put(CertificationListController());
  }

  @override
  Widget build(BuildContext context) {
    final dict = controller.dict;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColor.bgColor,
          child: Stack(
            children: [
              Column(
                children: [
                  SafeArea(
                    child: Obx(() {
                      final model = controller.authlistModel.value;
                      final imageStr = model.expect?.rule?.cautiously ?? '';
                      return AppHeadView(
                        title: 'Identity Authentication',
                        onTap: () async {
                          Get.dialog(
                            Container(
                              color: Colors.transparent,
                              child: LeaveView(
                                onTap: () async {
                                  if (imageStr.isEmpty) {
                                    Get.back();
                                    Get.back(result: 'refresh');
                                  } else {
                                    Get.until((route) {
                                      final currentRoute = route.settings.name
                                          ?.split('?')
                                          .first;
                                      return currentRoute ==
                                          ShineAppRouter.authList;
                                    });
                                    final cerVc =
                                        Get.find<CertificationListController>();
                                    await cerVc.initAuthListInfo(
                                      dict['productID'],
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 16.sp),
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
                                  newMethodImageClickView(imageStr, model),
                                  SizedBox(height: 24.h),
                                  newMethod(faceimageStr, model),
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
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: AppCommonFooterView(
                    title: 'Next',
                    onTap: () {
                      final model = controller.authlistModel.value;
                      final imageStr = model.expect?.rule?.cautiously ?? '';
                      final faceimageStr =
                          model.expect?.posted?.cautiously ?? '';
                      if (imageStr.isEmpty) {
                        controller.imageClick();
                        return;
                      }
                      if (faceimageStr.isEmpty) {
                        controller.faceClick();
                        return;
                      }
                      Get.until((route) {
                        final currentRoute = route.settings.name
                            ?.split('?')
                            .first;
                        return currentRoute == ShineAppRouter.authList;
                      });
                      final cerVc = Get.find<CertificationListController>();
                      cerVc.initAuthListInfo(cerVc.productID);
                      // final homeVc = Get.find<HomeController>();
                      // homeVc.getProductDetaiPageInfo(
                      //   productID: controller.dict['productID'],
                      //   type: '1',
                      //   inner: '1',
                      // );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newMethod(String faceimageStr, BaseModel model) {
    //face
    final icClick = model.expect?.posted?.listening;
    //image
    final icImageClick = model.expect?.rule?.listening;
    return imageClickView(
      title: 'Facial Recognition',
      imageStr: faceimageStr.isEmpty ? 'face_image.png' : faceimageStr,
      isClick: icClick == 1 ? false : true,
      onTap: icImageClick == 0 ? controller.imageClick : controller.faceClick,
    );
  }

  Widget newMethodImageClickView(String imageStr, BaseModel model) {
    final icClick = model.expect?.rule?.listening;
    return imageClickView(
      title: 'Upload ID Photos',
      imageStr: imageStr.isEmpty ? 'photo_imge.png' : imageStr,
      isClick: icClick == 1 ? false : true,
      onTap: controller.imageClick,
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
