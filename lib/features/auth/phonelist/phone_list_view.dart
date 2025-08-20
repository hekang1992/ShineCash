import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/imageface/progress_list_view.dart';
import 'package:shinecash/features/auth/phonelist/phone_cell_view.dart';
import 'package:shinecash/features/auth/phonelist/phone_enum_list.dart';
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
                                final model1 = controller.model.value;
                                return ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 12.sp,
                                    left: 12.sp,
                                    right: 12.sp,
                                  ),
                                  itemCount: model1.expect?.oily?.length ?? 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final model = model1.expect?.oily?[index];
                                    final relation = Relation.backRelation(
                                      type: model?.discovery ?? '',
                                    );
                                    final relationStr = relation;
                                    final phone = model?.sane ?? '';
                                    final name = model?.pens ?? '';
                                    final phoneName = '$name-$phone';
                                    return PhoneCellView(
                                      incColor1: relation.isEmpty
                                          ? 0xff888888
                                          : 0xff7262EC,
                                      incColor2: phoneName == '-'
                                          ? 0xff888888
                                          : 0xff7262EC,
                                      one: model?.acquainted ?? '',
                                      two: relationStr.isEmpty
                                          ? (model?.diseases ?? '')
                                          : relationStr,
                                      three: phoneName == '-'
                                          ? (model?.skilled ?? '')
                                          : phoneName,
                                      onTap1: () {
                                        Get.bottomSheet(
                                          isDismissible: false,
                                          enableDrag: false,
                                          PhoneEnumList(
                                            model: model ?? OilyModel(),
                                            listModel: model?.sincerely ?? [],
                                            controller: controller,
                                            fatherIndex: index,
                                            onTap: () {
                                              Get.back();
                                            },
                                          ),
                                        );
                                      },
                                      onTap2: () async {
                                        final contact =
                                            await PhoneNameChannel.pickContact();
                                        model?.pens = contact?.pens;
                                        model?.sane = contact?.ever;
                                        controller.model.refresh();
                                        if (contact == null) {
                                          return;
                                        }
                                        final allList =
                                            await PhoneNameChannel.getAllContacts();
                                        print('allList🤢--------$allList');
                                        List listArray =
                                            <Map<String, dynamic>>[];
                                        for (var model in allList) {
                                          listArray.add({
                                            'ever': model.ever,
                                            'pens': model.pens,
                                          });
                                        }
                                        String jsonString = jsonEncode(
                                          listArray,
                                        );
                                        await controller.uploadAllInfo(
                                          expect: jsonString,
                                        );
                                      },
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
                                List<Map<String, dynamic>> dictArray = [];
                                for (OilyModel model
                                    in controller.model.value.expect?.oily ??
                                        []) {
                                  final listDict = {
                                    'pens': model.pens ?? '',
                                    'discovery': model.discovery ?? '',
                                    'sane': model.sane ?? '',
                                  };
                                  dictArray.add(listDict);
                                }
                                final expect = jsonEncode(dictArray);
                                await controller.saveAllInfo(
                                  expect: expect,
                                  productID: controller.productID,
                                );
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

class Relation {
  static String backRelation({required String type}) {
    switch (type) {
      case '1':
        return 'Parent';
      case '2':
        return 'Spouse';
      case '3':
        return 'Child';
      case '4':
        return 'Sibling';
      case '5':
        return 'Friend';
      case '6':
        return 'Colleague';
      case '7':
        return 'other';
      default:
        return '';
    }
  }
}
