import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/api_constants.dart';
import 'package:innerly/core/controllers/auth_controller.dart';
class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl, // e.g. https://api.innerly.app
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      _authInterceptor(),
      if (ApiConstants.enableLogging) _loggingInterceptor(),
    ]);
  }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final response = await Supabase.instance.client.auth.refreshSession();
            if (response.session != null) {
              error.requestOptions.headers['Authorization'] =
                  'Bearer ${response.session!.accessToken}';
              final retry = await dio.fetch(error.requestOptions);
              return handler.resolve(retry);
            }
          } catch (_) {
            Get.find<AuthController>().logout();
          }
        }
        return handler.next(error);
      },
    );
  }

  InterceptorsWrapper _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        print('➡️ ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('✅ ${response.statusCode} ${response.requestOptions.uri}');
        return handler.next(response);
      },
      onError: (error, handler) {
        print('❌ ${error.response?.statusCode} ${error.requestOptions.uri} — ${error.message}');
        return handler.next(error);
      },
    );
  }
}