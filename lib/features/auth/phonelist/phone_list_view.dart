import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/imageface/progress_list_view.dart';
import 'package:shinecash/features/auth/phonelist/phone_cell_view.dart';
import 'package:shinecash/features/auth/phonelist/phone_list_controller.dart';

class PhoneListView extends GetView<PhoneListController> {
  PhoneListView({super.key}) {
    final _ = Get.put(PhoneListController());
  }

  @override
  Widget build(BuildContext context) {
    final cerVc = Get.find<CertificationListController>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            color: AppColor.bgColor,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SafeArea(
                  child: AppHeadView(
                    title: 'Emergency Contact',
                    onTap: () async {
                      Get.until((route) {
                        final currentRoute = route.settings.name
                            ?.split('?')
                            .first;
                        return currentRoute == ShineAppRouter.authList;
                      });
                      await cerVc.initAuthListInfo(controller.productID);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 52.h,
                  ),
                  child: Column(
                    children: [
                      ProgressListView(pix: 0.8),
                      SizedBox(height: 16.sp),
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Image.asset(
                            'assets/images/cycle_auth_image.png',
                            width: 37.w,
                            height: 23.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 12.sp,
                              left: 12.sp,
                              right: 12.sp,
                            ),
                            child: Container(
                              height: 520.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9.sp),
                                ),
                              ),
                              child: Obx(() {
                                final model = controller.model.value;
                                return ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 12.sp,
                                    left: 12.sp,
                                    right: 12.sp,
                                  ),
                                  itemCount: model.expect?.oily?.length ?? 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final listModel =
                                        model.expect?.oily?[index];
                                    return PhoneCellView(
                                      one: listModel?.acquainted ?? '',
                                      two: listModel?.diseases ?? '',
                                      three: listModel?.skilled ?? '',
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Expanded(
                        child: Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: AppCommonFooterView(
                              title: 'Next',
                              onTap: () async {
                                Map<String, dynamic> dict = {
                                  'nodded': controller.productID,
                                };
                                for (TemporaryModel model
                                    in controller
                                            .model
                                            .value
                                            .expect
                                            ?.temporary ??
                                        []) {
                                  final listDict = {
                                    model.beautiful ?? '': model.angrily ?? '',
                                  };
                                  dict.addAll(listDict);
                                }
                                print('dict🤢--------$dict');
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
