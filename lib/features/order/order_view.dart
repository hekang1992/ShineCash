import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/order/order_controller.dart';
import 'package:shinecash/features/order/order_list_view.dart';

class OrderView extends GetView<OrderController> {
  final tabs = ['All', 'Under Review', 'Repaying', 'Completed'];

  OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: SafeArea(
          child: Column(
            children: [
              Obx(
                () => AppHeadView(
                  title: 'Orders',
                  isShowBack: controller.isShowBack.value,
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              SizedBox(height: 10.h),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: List.generate(tabs.length, (index) {
                      final isSelected = controller.currentIndex.value == index;
                      return InkWell(
                        onTap: () {
                          controller.makeChage(changeIndex: index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tabs[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white54,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),

                              Container(
                                height: 2.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              Expanded(
                child: Obx(() {
                  final model = controller.model.value;
                  final modelArray = model.expect?.centuries ?? [];
                  return modelArray.isEmpty
                      ? Center(
                          child: Image.asset(
                            'assets/images/empty_image_k.png',
                            width: 150.w,
                            height: 182.h,
                            fit: BoxFit.contain,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await controller.makeChage(
                              changeIndex: controller.currentIndex.value,
                            );
                          },
                          child: ListView.builder(
                            itemCount: model.expect?.centuries?.length ?? 0,
                            itemBuilder: (content, index) {
                              final listModel =
                                  model.expect?.centuries?[index] ??
                                  CenturiesModel();
                              return OrderListView(
                                listModel: listModel,
                                onTap: () async {
                                  final ends = listModel.ends ?? '';
                                  if (ends.contains(productDetailSchemeUrl)) {
                                    final dict =
                                        GetQueryParametersAll.getQueryParametersAll(
                                          ends,
                                        );
                                    final productID =
                                        dict['nodded']?.first ?? '';
                                    Get.toNamed(
                                      ShineAppRouter.authList,
                                      arguments: {'productID': productID},
                                    );
                                  } else {
                                    final pageUrl =
                                        await ApiUrlManager.getApiUrl(ends);
                                    Get.toNamed(
                                      ShineAppRouter.web,
                                      arguments: {'pageUrl': pageUrl},
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
