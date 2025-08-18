import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/listpage/one_list_view.dart';
import 'package:shinecash/features/auth/listpage/tin_list_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';

class TinListView extends GetView<TinListController> {
  const TinListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cerVc = Get.find<CertificationListController>();
    final productID = cerVc.productID;
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
                  title: 'Select Identity Document',
                  onTap: () async {
                    Get.back(result: 'refresh');
                    await cerVc.initAuthListInfo(productID);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.h,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Obx(() {
                    final homeVc = Get.find<HomeController>();
                    final model = homeVc.authlistModel.value;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 351.w,
                          height: 365.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.sp),
                            ),
                          ),
                          child: OneListView(
                            title: 'Recommended ID Type',
                            address: model.expect?.address ?? [],
                            onTap: (title) {
                              final dict = {
                                'title': title,
                                'productID': productID,
                              };
                              Get.toNamed(
                                ShineAppRouter.imagePhoto,
                                arguments: dict,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Container(
                          width: 351.w,
                          height: 365.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.sp),
                            ),
                          ),
                          child: OneListView(
                            title: 'Other Options',
                            address: model.expect?.communicate ?? [],
                            onTap: (title) {
                              final dict = {
                                'title': title,
                                'productID': productID,
                              };
                              Get.toNamed(
                                ShineAppRouter.imagePhoto,
                                arguments: dict,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
