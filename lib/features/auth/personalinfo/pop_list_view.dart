import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';

class PopListView extends StatefulWidget {
  final int index; // The index of this item in the list
  final String title;
  final bool isSelected;
  final ValueChanged<int> onSelected;

  const PopListView({
    super.key,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  State<StatefulWidget> createState() => PopListViewState();
}

class PopListViewState extends State<PopListView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onSelected(widget.index),
      child: _buildItem(widget.title, isSelected: widget.isSelected),
    );
  }

  Widget _buildItem(String text, {required bool isSelected}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.sp, left: 12.sp, right: 12.sp),
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
        border: Border.all(
          width: 1,
          color: isSelected ? Color(0XFF7262EC) : Color(0XFFEEEEFC),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.sp),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColor.orderTypeColor : AppColor.blackColor,
            ),
          ),
          Spacer(),
          if (isSelected)
            Image.asset(
              'assets/images/login_sel_image.png',
              width: 16.sp,
              height: 16.sp,
            ),
          SizedBox(width: 12.sp),
        ],
      ),
    );
  }
}
