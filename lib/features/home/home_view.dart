import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/home/onehome/home_one_view.dart';
import 'package:shinecash/features/home/onehome/home_three_view.dart';
import 'package:shinecash/features/home/onehome/home_two_view.dart';

class HomeView extends GetView {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColor.bgColor,
        child: Stack(
          children: [
            Image.asset('assets/images/home_gb_imge.png'),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    HomeOneView(
                      name1: 'Hi!',
                      name2: 'Shine Cash',
                      name3: 'home_head_logo_icon_image.png',
                    ),
                    SizedBox(height: 20.h),
                    HomeTwoView(
                      name1: 'home_money_image.png',
                      name2: 'Maximum Credit Limit',
                      name3: '₱60,000',
                      name4: 'Get It Immediately',
                    ),
                    SizedBox(height: 18.h),
                    HomeThreeView(
                      name1: 'home_three1_image.png',
                      name2: 'home_three2_image.png',
                      name3: 'home_three3_image.png',
                      name4: 'home_three4_image.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
