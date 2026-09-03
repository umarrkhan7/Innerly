import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:innerly/core/network/dio_client.dart';
import 'package:innerly/core/storage/storage_service.dart';

class AuthController extends GetxController {
  final DioClient dioClient;
  final StorageService storageService;

  AuthController(this.dioClient, this.storageService);

  final isLoggedIn = false.obs;
  final currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    final session = Supabase.instance.client.auth.currentSession;
    isLoggedIn.value = session != null;
    currentUser.value = session?.user;
  }

  Future<void> login(String email, String password) async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    currentUser.value = response.user;
    isLoggedIn.value = response.session != null;
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    await storageService.clearAll();
    isLoggedIn.value = false;
    currentUser.value = null;
  }
}