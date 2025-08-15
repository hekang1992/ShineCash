import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CerHeadView extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final String name5;

  const CerHeadView({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.name5,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name1,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  name2,
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Spacer(),
            if (name3.isNotEmpty)
              ClipOval(
                child: Image.network(
                  name3,
                  width: 72.w,
                  height: 72.h,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CircularProgressIndicator(
                      color: Colors.white,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    );
                  },
                ),
              ),
            SizedBox(width: 12.w),
          ],
        ),
        SizedBox(height: 15.h),
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              width: 351.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(0XFF6659D3),
                borderRadius: BorderRadius.all(Radius.circular(16.sp)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.sp, left: 28.sp, right: 28.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name4,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Text(
                    name5,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
