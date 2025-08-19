import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';

class CerReallistView extends StatelessWidget {
  final SorryModel model;
  final VoidCallback onTap;
  const CerReallistView({super.key, required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 84.h,
        margin: EdgeInsets.only(bottom: 8.sp),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          border: Border.all(
            color: Color(0XFFEEEEFC), // Red border color
            width: 1.0, // 1 pixel width
          ),
          borderRadius: BorderRadius.circular(9.sp), // 9 pixels rounded corners
        ),
        child: Row(
          children: [
            SizedBox(width: 12.sp),
            Image.network(
              'http://ph01-dc.oss-ap-southeast-6.aliyuncs.com/202412/20241209174307_ticoy07qwy.png?OSSAccessKeyId=LTAI5tQ4Eqf4UjPtizyvPNBG&Expires=1922953387&Signature=NUgglJ6I9wtwZUognW2CLeCt3Mk%3D',
              // model.gentlemen ?? '',
              width: 68.w,
              height: 68.h,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator(
                  color: Color(0XFF7262EC),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                );
              },
            ),
            SizedBox(width: 12.w),
            Container(
              color: Colors.transparent,
              width: 212.w,
              height: 84.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.acquainted ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    softWrap: true,
                    model.unread ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Image.asset(
              model.listening == 0
                  ? 'assets/images/next_btn_image.png'
                  : 'assets/images/login_sel_image.png',
              width: model.listening == 0 ? 7.w : 15.w,
              height: model.listening == 0 ? 12.h : 15.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 5.w),
          ],
        ),
      ),
    );
  }
}
