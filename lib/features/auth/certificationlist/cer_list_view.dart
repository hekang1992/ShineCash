import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/features/auth/certificationlist/cer_reallist_view.dart';

class CerListView extends StatelessWidget {
  final BaseModel model;
  final void Function(SorryModel) onTap;
  const CerListView({super.key, required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(
          'assets/images/cycle_auth_image.png',
          width: 37.w,
          height: 23.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Container(
            width: 351.w,
            height: 540.h,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(16.sp)),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 16.sp, left: 12.sp, right: 12.sp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: AppColor.bgColor,
                        width: 4.w,
                        height: 16.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Certification Flow',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    padding: EdgeInsets.only(top: 16.sp),
                    shrinkWrap: true,
                    itemCount: model.expect?.sorry?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final model =
                          this.model.expect?.sorry?[index] ?? SorryModel();
                      return CerReallistView(
                        model: model,
                        onTap: () {
                          onTap(model);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
