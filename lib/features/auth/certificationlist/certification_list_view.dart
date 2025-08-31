import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/auth/certificationlist/cer_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/cer_list_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';
import 'package:shinecash/features/order/order_controller.dart';

class CertificationListView extends GetView<CertificationListController> {
  CertificationListView({super.key}) {
    final _ = Get.put(CertificationListController());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          color: AppColor.bgColor,
          width: double.infinity,
          child: Stack(
            children: [
              SafeArea(
                child: Obx(() {
                  final model = controller.model.value;
                  return AppHeadView(
                    title: model.expect?.egyptian?.correspondent ?? '',
                    onTap: () {
                      Get.back(result: {'type': 'order_list'});
                      FindHomeVc.getHomeVc();
                      if (Get.isRegistered<OrderController>()) {
                        final orderVc = Get.find<OrderController>();
                        orderVc.makeChage(
                          changeIndex: orderVc.currentIndex.value,
                        );
                      }
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.sp,
                  bottom: 98.sp,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Obx(() {
                        final model = controller.model.value;
                        return CerHeadView(
                          name1: model.expect?.egyptian?.glanced ?? '',
                          name2:
                              '${model.expect?.egyptian?.symbol ?? ''}${model.expect?.egyptian?.wink ?? ''}',
                          name3: model.expect?.egyptian?.imaginary ?? '',
                          name4:
                              '${model.expect?.egyptian?.considering?.ludicrous?.acquainted ?? ''}: ${model.expect?.egyptian?.considering?.ludicrous?.robes ?? ''}',
                          name5:
                              '${model.expect?.egyptian?.considering?.mistress?.acquainted ?? ''}: ${model.expect?.egyptian?.considering?.mistress?.robes ?? ''}',
                        );
                      }),
                      SizedBox(height: 6.h),
                      Obx(() {
                        return CerListView(
                          model: controller.model.value,
                          onTap: (model) async {
                            final homeVc = Get.find<HomeController>();
                            final sitting = model.sitting ?? '';
                            final listening = model.listening ?? 0;
                            if (listening == 1) {
                              if (sitting != 'desertion') {
                                homeVc.pushToPage(
                                  authStr: sitting,
                                  productID: controller.productID,
                                  type: '1',
                                  cautiously: '',
                                );
                              } else {
                                final cautiously = model.cautiously ?? '';
                                final pageUrl = await ApiUrlManager.getApiUrl(
                                  cautiously,
                                );
                                Get.toNamed(
                                  ShineAppRouter.web,
                                  arguments: {'pageUrl': pageUrl},
                                );
                              }
                            } else {
                              homeVc.getProductDetaiPageInfo(
                                productID: controller.productID,
                                type: '1',
                                inner: '1',
                              );
                            }

                            // ToastManager.showToast(
                            //   '🔥${model.acquainted ?? ''}',
                            // );
                          },
                        );
                      }),
                      SizedBox(height: 16.h),
                      if ((controller.model.value.expect?.after?.waive ?? '')
                          .isNotEmpty)
                        SizedBox(
                          width: 351.w,
                          child: InkWell(
                            onTap: () {
                              final pageUrl =
                                  controller.model.value.expect?.after?.waive ??
                                  '';
                              Get.toNamed(
                                ShineAppRouter.web,
                                arguments: {'pageUrl': pageUrl},
                              );
                            },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Please go through the ',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Loan Agreement',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' Your personal details are kept strictly confidential as required by data laws.',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 80.h,
                  child: Obx(() {
                    return AppCommonFooterView(
                      title:
                          controller.model.value.expect?.egyptian?.appeal ?? '',
                      onTap: () {
                        final homeVc = Get.find<HomeController>();
                        homeVc.getProductDetaiPageInfo(
                          productID: controller.productID,
                          type: '1',
                          inner: '0',
                        );
                      },
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
