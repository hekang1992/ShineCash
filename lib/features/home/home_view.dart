import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
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
                  controller.uploadlocation();
                  controller.uploaddeviceInfo();
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Obx(() {
                      final model = controller.model.value;
                      controller.listArray.clear();
                      for (CenturiesModel element
                          in model.expect?.centuries ?? []) {
                        final key = element.many ?? '';
                        final value = element.died ?? [];
                        final Map<String, List<DiedModel>> dict = {key: value};
                        controller.listArray.add(dict);
                      }
                      bool hasReceivedKey = controller.listArray.any(
                        (map) => map.containsKey('received'),
                      );
                      if (hasReceivedKey) {
                        Map<String, List<DiedModel>> receivedDict = controller
                            .listArray
                            .firstWhere(
                              (dict) =>
                                  dict.keys.any((k) => k.contains('received')),
                            );
                        String actualKey = receivedDict.keys.firstWhere(
                          (k) => k.contains('received'),
                        );
                        List<DiedModel> listModel =
                            receivedDict[actualKey] ?? [];
                        return Column(
                          children: [
                            HomeOneView(
                              name1: 'Hi!',
                              name2: listModel.first.correspondent ?? '',
                              name3: listModel.first.imaginary ?? '',
                              onTap: () {
                                final tab = Get.find<TabbarController>();
                                tab.changeIndex(2);
                              },
                            ),
                            SizedBox(height: 20.h),
                            HomeTwoView(
                              name1: 'home_money_image.png',
                              name2: listModel.first.reduced ?? '',
                              name3: listModel.first.condition ?? '',
                              name4: listModel.first.appeal ?? '',
                              onTap: () async {
                                final productID = (listModel.first.hasten ?? 0)
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
                      } else {
                        /// banner
                        Map<String, List<DiedModel>> receivedDict1 = controller
                            .listArray
                            .firstWhere(
                              (dict) =>
                                  dict.keys.any((k) => k.contains('stopped')),
                            );
                        String actualKey1 = receivedDict1.keys.firstWhere(
                          (k) => k.contains('stopped'),
                        );
                        List<DiedModel> listModel1 =
                            receivedDict1[actualKey1] ?? [];

                        /// 小咖位
                        Map<String, List<DiedModel>> receivedDict2 = controller
                            .listArray
                            .firstWhere(
                              (dict) => dict.keys.any((k) => k.contains('the')),
                            );
                        String actualKey2 = receivedDict2.keys.firstWhere(
                          (k) => k.contains('the'),
                        );
                        List<DiedModel> listModel2 =
                            receivedDict2[actualKey2] ?? [];

                        /// 极速列表
                        Map<String, List<DiedModel>> receivedDict3 = controller
                            .listArray
                            .firstWhere(
                              (dict) =>
                                  dict.keys.any((k) => k.contains('said')),
                            );
                        String actualKey3 = receivedDict3.keys.firstWhere(
                          (k) => k.contains('said'),
                        );
                        List<DiedModel> listModel3 =
                            receivedDict3[actualKey3] ?? [];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              listModel2.first.correspondent ?? '',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12.sp),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 12.sp,
                                right: 12.sp,
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 84.0,
                                  enableInfiniteScroll: listModel1.length > 1
                                      ? true
                                      : false,
                                  autoPlay: listModel1.length > 1
                                      ? true
                                      : false,
                                  autoPlayInterval: Duration(seconds: 3),
                                  viewportFraction: 1,
                                ),
                                items: listModel1.map((model) {
                                  return InkWell(
                                    onTap: () async {
                                      final cautiously = model.cautiously ?? '';
                                      if (cautiously.isEmpty) {
                                        return;
                                      } else {
                                        final pageUrl =
                                            await ApiUrlManager.getApiUrl(
                                              cautiously,
                                            );
                                        Get.toNamed(
                                          ShineAppRouter.web,
                                          arguments: {'pageUrl': pageUrl},
                                        );
                                      }
                                    },
                                    child: Image.network(
                                      model.throne ?? '',
                                      width: double.infinity,
                                      height: 84.h,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.white,
                                              child: Icon(
                                                Icons.error_outline,
                                                size: 375.w,
                                              ),
                                            );
                                          },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 16.sp),
                            InkWell(
                              onTap: () async {
                                final productID = (listModel2.first.hasten ?? 0)
                                    .toString();
                                await controller.applyProductWithID(productID);
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [
                                  Image.asset(
                                    'assets/images/p_hom_one.png',
                                    width: 351.w,
                                    height: 211.h,
                                    fit: BoxFit.contain,
                                  ),
                                  Positioned(
                                    top: 41.sp,
                                    left: 28.sp,
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            listModel2.first.imaginary ?? '',
                                            width: 32.w,
                                            height: 32.h,
                                          ),
                                        ),
                                        SizedBox(width: 8.sp),
                                        Text(
                                          listModel2.first.correspondent ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 11.sp,
                                    right: 5.sp,
                                    child: Transform.rotate(
                                      angle: 45 * (pi / 180),
                                      child: Text(
                                        listModel2.first.disappointment ?? '',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 70.sp,
                                    left: 28.sp,
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width -
                                          80.sp,
                                      child: Row(
                                        children: [
                                          Text(
                                            listModel2.first.reduced ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Color(0xff888888),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            listModel2.first.condition ?? '',
                                            style: TextStyle(
                                              fontSize: 30.sp,
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 13.sp,
                                    child: Container(
                                      width: 327.w,
                                      height: 44.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(9.sp),
                                        ),
                                        color: AppColor.bgColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          listModel2.first.appeal ?? '',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.sp),
                            SizedBox(height: 12.sp),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 18.sp),
                                  Row(
                                    children: [
                                      SizedBox(width: 12.sp),
                                      Container(
                                        height: 16.h,
                                        width: 4.w,
                                        decoration: BoxDecoration(
                                          color: AppColor.bgColor,
                                          borderRadius: BorderRadius.circular(
                                            2.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.sp),
                                      Text(
                                        "More Products",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.sp),
                                  //极速列表
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listModel3.length,
                                    itemBuilder: (context, index) {
                                      final listModel = listModel3[index];
                                      return InkWell(
                                        onTap: () async {
                                          final productID =
                                              (listModel.hasten ?? 0)
                                                  .toString();
                                          await controller.applyProductWithID(
                                            productID,
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            bottom: 12.sp,
                                          ),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.topCenter,
                                            children: [
                                              Image.asset(
                                                'assets/images/pro_adc_image.png',
                                                width: 351.w,
                                                height: 180.h,
                                              ),
                                              Positioned(
                                                top: 14.sp,
                                                left: 24.sp,
                                                child: SizedBox(
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width -
                                                      50.sp,
                                                  child: Row(
                                                    children: [
                                                      ClipOval(
                                                        child: Image.network(
                                                          listModel.imaginary ??
                                                              '',
                                                          width: 32.w,
                                                          height: 32.h,
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.sp),
                                                      Text(
                                                        listModel
                                                                .correspondent ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left: 20.sp,
                                                              right: 20.sp,
                                                              top: 8.sp,
                                                              bottom: 8.sp,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                9.sp,
                                                              ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            listModel.appeal ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: AppColor
                                                                  .bgColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 88.sp,
                                                left: 24.sp,
                                                child: SizedBox(
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width -
                                                      50.sp,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        listModel.reduced ?? '',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Color(
                                                            0xff888888,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        listModel.condition ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 26.sp,
                                                          color: Color(
                                                            0xff222222,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 20.sp,
                                                left: 24.sp,
                                                child: Row(
                                                  children: [
                                                    for (String title
                                                        in listModel.teacher ??
                                                            [])
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  left: 8.sp,
                                                                  right: 8.sp,
                                                                  top: 4.sp,
                                                                  bottom: 4.sp,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color: Color(
                                                                0xffEEEEFC,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                    Radius.circular(
                                                                      9.sp,
                                                                    ),
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              title,
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: AppColor
                                                                    .bgColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 8.sp),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.sp),
                          ],
                        );
                      }
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
