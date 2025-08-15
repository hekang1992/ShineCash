import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveLoginInfo.init();
  runApp(ShineApp());
}

class ShineApp extends StatefulWidget {
  const ShineApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return ShineAppState();
  }
}

class ShineAppState extends State {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        initialRoute: ShineAppRouter.splash,
        getPages: ShineAppRouter.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
