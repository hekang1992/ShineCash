import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/cer_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';

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
                child: AppHeadView(
                  title: 'Certification List',
                  onTap: () {
                    Get.back();
                    FindHomeVc.getHomeVc();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.h,
                ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
