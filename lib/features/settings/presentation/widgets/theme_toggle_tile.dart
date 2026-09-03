import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innerly/core/controllers/theme_controller.dart';

class ThemeToggleTile extends StatelessWidget {
  const ThemeToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();

    return Obx(() => ListTile(
      title: const Text('Appearance'),
      trailing: SegmentedButton<ThemeMode>(
        segments: const [
          ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode)),
          ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto)),
          ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode)),
        ],
        selected: {controller.themeMode.value},
        onSelectionChanged: (selection) => controller.setThemeMode(selection.first),
      ),
    ));
  }
}