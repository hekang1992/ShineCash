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
import 'package:shinecash/features/auth/personalinfo/auth_one_enum_view.dart';
import 'package:shinecash/features/auth/personalinfo/input_click_view.dart';
import 'package:shinecash/features/auth/work/workinfo_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';

class WorkinfoView extends GetView<WorkinfoController> {
  WorkinfoView({super.key}) {
    final _ = Get.put(WorkinfoController());
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
            width: MediaQuery.of(context).size.width,
            color: AppColor.bgColor,
            child: Stack(
              children: [
                Column(
                  children: [
                    SafeArea(
                      child: AppHeadView(
                        title: 'Work Info',
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
                    ProgressListView(pix: 0.6),
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
                          padding: EdgeInsets.only(top: 12.sp),
                          child: Container(
                            width: 351.w,
                            height: 520.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.sp),
                              ),
                            ),
                            child: Obx(() {
                              final model = controller.model.value;
                              final temporary = model.expect?.temporary ?? [];
                              return ListView.builder(
                                padding: EdgeInsets.all(12.sp),
                                itemCount: model.expect?.temporary?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final model = temporary[index];
                                  final necessity = model.necessity ?? '';
                                  final enable = necessity == 'Kenyon'
                                      ? true
                                      : false;
                                  return InputClickView(
                                    model: model,
                                    enable: enable,
                                    controller:
                                        controller.textControllers[index],
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (necessity == 'Mrs') {
                                        final homeVc =
                                            Get.find<HomeController>();
                                        final modelArray =
                                            homeVc
                                                .citylistModel
                                                .value
                                                .expect
                                                ?.centuries ??
                                            [];
                                        controller.showPicker(
                                          modelArray,
                                          context,
                                          cityBlock: (name) {
                                            controller
                                                    .textControllers[index]
                                                    .text =
                                                name;
                                            model.angrily = name;
                                          },
                                        );
                                      } else {
                                        Get.bottomSheet(
                                          isDismissible: false,
                                          enableDrag: false,
                                          AuthOneEnumView(
                                            onTap: () {
                                              Get.back();
                                            },
                                            model: model,
                                            listModel: model.sincerely ?? [],
                                            controller: controller,
                                            fatherIndex: index,
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: AppCommonFooterView(
                      title: 'Next',
                      onTap: () async {
                        Map<String, dynamic> dict = {
                          'nodded': controller.productID,
                        };
                        var sureVale = '';
                        for (TemporaryModel model
                            in controller.model.value.expect?.temporary ?? []) {
                          if (model.necessity == 'vain') {
                            for (SincerelyModel element
                                in model.sincerely ?? []) {
                              if (element.pens == model.angrily) {
                                sureVale = element.many.toString();
                              }
                            }
                          } else {
                            sureVale = model.angrily ?? '';
                          }
                          final listDict = {model.beautiful ?? '': sureVale};
                          dict.addAll(listDict);
                        }
                        print('dict🤢--------$dict');
                        await controller.saveInfo(dict);
                      },
                    ),
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
