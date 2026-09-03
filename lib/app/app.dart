import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innerly/app/bindings/initial_binding.dart';
import 'package:innerly/app/theme/app_theme.dart';
import 'package:innerly/app/routes/app_routes.dart';
import 'package:innerly/app/routes/app_pages.dart';
import 'package:innerly/core/controllers/theme_controller.dart';

class InnerlyApp extends StatelessWidget {
  const InnerlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Innerly',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.find<ThemeController>().themeMode.value,
    );
  }
}