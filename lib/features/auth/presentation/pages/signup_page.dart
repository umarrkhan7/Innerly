import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../controllers/signup_controller.dart';
import '../widgets/auth_text_field.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.darkBackground, AppColors.darkSurface]
                : [AppColors.lightBackground, AppColors.insight.withValues(alpha: 0.20)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.darkText : AppColors.lightText),
                ),
                const SizedBox(height: 12),
                Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Start understanding yourself better',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
                const SizedBox(height: 32),

                Obx(() => AuthTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  isValid: controller.isEmailValid.value,
                  showValidation: controller.email.value.isNotEmpty,
                )),
                const SizedBox(height: 16),

                Obx(() => AuthTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.obscurePassword.value,
                  isValid: controller.isPasswordValid.value,
                  showValidation: controller.password.value.isNotEmpty,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.softBlue,
                      size: 20,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                )),
                const SizedBox(height: 16),

                Obx(() => AuthTextField(
                  controller: controller.confirmPasswordController,
                  label: 'Confirm password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.obscurePassword.value,
                  isValid: controller.doPasswordsMatch.value,
                  showValidation: controller.confirmPassword.value.isNotEmpty,
                )),

                Obx(() => controller.errorMessage.value != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(controller.errorMessage.value!, style: const TextStyle(color: AppColors.error, fontSize: 13)),
                      )
                    : const SizedBox.shrink()),

                const SizedBox(height: 28),

                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: controller.canSubmit ? controller.signup : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.4))
                        : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                )),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}