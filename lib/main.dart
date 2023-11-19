import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/base_controller.dart';
import 'res/app_colors.dart';
import 'res/app_strings.dart';
import 'res/app_theme.dart';
import 'res/color_print.dart';
import 'views/demo/new_demo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await LocalStorage.readDataInfo();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          initialBinding: LazyBinding(),
          themeMode: ThemeMode.dark,
          theme: AppTheme.lightMode(
            kPrimaryColor: AppColors.kPrimaryColor,
            kBackgroundColor: AppColors.kBackgroundColor,
            errorColor: AppColors.errorColor,
            fontFamily: AppTheme.fontFamilyName,
          ),
          darkTheme: AppTheme.darkMode(
            kPrimaryColor: AppColors.kPrimaryColor,
            kBackgroundColor: AppColors.kBackgroundColor,
            errorColor: AppColors.errorColor,
            fontFamily: AppTheme.fontFamilyName,
          ),
          // getPages: AppPages.pages,
          // initialRoute: AppRoutes.splashScreen,
          home: const NewDemoScreen(),
        );
      },
    );
  }
}

class LazyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
    printData(key: "Get.put", value: BaseController);
  }
}
