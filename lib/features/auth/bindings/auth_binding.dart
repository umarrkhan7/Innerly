import 'package:get/get.dart';
import '../data/repositories/auth_repository.dart';
import '../controllers/login_controller.dart';
import '../controllers/signup_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => LoginController(Get.find<AuthRepository>()));
    Get.lazyPut(() => SignupController(Get.find<AuthRepository>()));
  }
}