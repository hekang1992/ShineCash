import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOneView extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;

  const HomeOneView({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                name2,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          Image.asset('assets/images/$name3', width: 30.w, height: 30.w),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
