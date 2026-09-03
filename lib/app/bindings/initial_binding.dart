import 'package:get/get.dart';
import 'package:innerly/core/network/dio_client.dart';
import 'package:innerly/core/storage/storage_service.dart';
import 'package:innerly/core/controllers/auth_controller.dart';
import 'package:innerly/core/controllers/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioClient(), permanent: true);
    Get.put(StorageService(), permanent: true);
    Get.put(AuthController(Get.find<DioClient>(), Get.find<StorageService>()), permanent: true);
    Get.put(ThemeController(Get.find<StorageService>()), permanent: true);
  }
}