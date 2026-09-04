import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repositories/auth_repository.dart';
import '../../../app/routes/app_routes.dart';

class SignupController extends GetxController {
  final AuthRepository authRepository;
  SignupController(this.authRepository);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;
  final doPasswordsMatch = false.obs;
  final obscurePassword = true.obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  bool get canSubmit =>
      isEmailValid.value && isPasswordValid.value && doPasswordsMatch.value && !isLoading.value;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
    confirmPasswordController.addListener(_onConfirmChanged);
  }

  void _onEmailChanged() {
    email.value = emailController.text;
    isEmailValid.value = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email.value);
    errorMessage.value = null;
  }

  void _onPasswordChanged() {
    password.value = passwordController.text;
    isPasswordValid.value = password.value.length >= 6;
    doPasswordsMatch.value = password.value == confirmPassword.value && password.value.isNotEmpty;
    errorMessage.value = null;
  }

  void _onConfirmChanged() {
    confirmPassword.value = confirmPasswordController.text;
    doPasswordsMatch.value = password.value == confirmPassword.value && confirmPassword.value.isNotEmpty;
    errorMessage.value = null;
  }

  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;

  Future<void> signup() async {
    if (!canSubmit) return;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await authRepository.signUp(email: email.value, password: password.value);
      Get.offAllNamed(Routes.login);
      Get.snackbar('Success', 'Account created — please log in');
    } on Object catch (e) {
      errorMessage.value = 'Could not create account. Try a different email.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}