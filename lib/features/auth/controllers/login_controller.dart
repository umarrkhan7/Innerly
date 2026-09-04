import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repositories/auth_repository.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  LoginController(this.authRepository);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final email = ''.obs;
  final password = ''.obs;
  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;
  final obscurePassword = true.obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  bool get canSubmit => isEmailValid.value && isPasswordValid.value && !isLoading.value;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    email.value = emailController.text;
    isEmailValid.value = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email.value);
    errorMessage.value = null;
  }

  void _onPasswordChanged() {
    password.value = passwordController.text;
    isPasswordValid.value = password.value.length >= 6;
    errorMessage.value = null;
  }

  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;

  Future<void> login() async {
    if (!canSubmit) return;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await authRepository.signIn(email: email.value, password: password.value);
      Get.find<AuthController>().onInit(); // refresh session state
      Get.offAllNamed(Routes.home);
    } on Object catch (e) {
      errorMessage.value = 'Invalid email or password';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}