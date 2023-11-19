import 'package:get/get.dart';

class SplashController extends GetxController {
  navigate() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        // Get.offAllNamed(AppRoutes.dashboardScreen);
      },
    );
  }

  @override
  onReady() async {
    super.onReady();
    navigate();
  }
}
