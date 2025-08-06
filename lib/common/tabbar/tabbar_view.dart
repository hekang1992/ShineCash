import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/features/center/center_view.dart';
import 'package:shinecash/features/home/home_view.dart';
import 'package:shinecash/features/order/order_view.dart';

class TabbarView extends GetView<TabbarController> {
  TabbarView({super.key});

  final List<Widget> _widgetOptions = [HomeView(), OrderView(), CenterView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(() => _widgetOptions[controller.selectedIndex.value]),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          child: Material(
            color: Colors.white, // 圆角容器的背景色
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _TabIcon(name: 'home_nor.png'),
                  activeIcon: _TabIcon(name: 'home_sel.png'),
                  label: 'a',
                ),
                BottomNavigationBarItem(
                  icon: _TabIcon(name: 'order_nor.png'),
                  activeIcon: _TabIcon(name: 'order_sel.png'),
                  label: 'b',
                ),
                BottomNavigationBarItem(
                  icon: _TabIcon(name: 'center_nor.png'),
                  activeIcon: _TabIcon(name: 'center_sel.png'),
                  label: 'c',
                ),
              ],
              currentIndex: controller.selectedIndex.value,
              onTap: (value) => controller.changeIndex(value),
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        ),
      ),
    );
  }
}

class _TabIcon extends StatelessWidget {
  final String name;

  const _TabIcon({required this.name});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/$name', width: 40.w, height: 40.h);
  }
}
