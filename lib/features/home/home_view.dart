import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';
import 'package:shinecash/features/home/onehome/home_one_view.dart';
import 'package:shinecash/features/home/onehome/home_tzhree_view.dart';
import 'package:shinecash/features/home/onehome/home_two_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColor.bgColor,
        child: Stack(
          children: [
            Image.asset('assets/images/home_gb_imge.png'),
            Padding(
              padding: EdgeInsets.only(top: 10.sp),
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.initHomeInfo();
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Obx(() {
                      final model = controller.model.value;
                      DiedModel listModel = DiedModel();
                      for (final element in model.expect?.centuries ?? []) {
                        if (element.many == 'received') {
                          if (element.died?.isNotEmpty == true) {
                            listModel = element.died!.first;
                          } else {
                            listModel = DiedModel();
                          }
                        }
                      }
                      return Column(
                        children: [
                          HomeOneView(
                            name1: 'Hi!',
                            name2: listModel.correspondent ?? '',
                            name3: listModel.imaginary ?? '',
                            onTap: () {
                              final tab = Get.find<TabbarController>();
                              tab.changeIndex(2);
                            },
                          ),
                          SizedBox(height: 20.h),
                          HomeTwoView(
                            name1: 'home_money_image.png',
                            name2: listModel.reduced ?? '',
                            name3: listModel.condition ?? '',
                            name4: listModel.appeal ?? '',
                            onTap: () async {
                              final productID = (listModel.hasten ?? 0)
                                  .toString();
                              // 申请
                              await controller.applyProductWithID(productID);
                            },
                          ),
                          SizedBox(height: 18.h),
                          HomeTzhreeView(
                            name1: 'home_three1_image.png',
                            name2: 'home_three2_image.png',
                            name3: 'home_three3_image.png',
                            name4: 'home_three4_image.png',
                            onTap1: () {
                              ToastManager.showToast('msg1');
                            },
                            onTap2: () {
                              Get.toNamed(ShineAppRouter.guide);
                            },
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
