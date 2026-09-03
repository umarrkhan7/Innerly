import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../storage/storage_service.dart';

class ThemeController extends GetxController {
  final StorageService storageService;
  ThemeController(this.storageService);

  final themeMode = ThemeMode.system.obs;

  static const String storageKey = 'theme_mode';

  @override
  void onInit() {
    super.onInit();
    loadSavedTheme();
  }

  Future<void> loadSavedTheme() async {
    final saved = await storageService.getString(storageKey);
    themeMode.value = switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    await storageService.setString(storageKey, mode.name);
  }
}