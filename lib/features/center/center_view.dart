import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/features/center/center_controller.dart';
import 'package:shinecash/features/center/center_head_view.dart';

class CenterView extends GetView<CenterController> {
  const CenterView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CenterController());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColor.bgColor,
        child: Stack(
          children: [
            Image.asset('assets/images/home_gb_imge.png', fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.only(top: 10.sp),
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.initCenterInfo();
                },
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.sp),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: CenterHeadView(),
                    ),
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
