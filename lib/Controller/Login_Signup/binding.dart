import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/Login_Signup/auth_controller.dart';

import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
