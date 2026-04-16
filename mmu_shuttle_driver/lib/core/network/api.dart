import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/core/authentication/token_manager.dart';
import 'package:mmu_shuttle_driver/core/constants.dart';
import 'package:mmu_shuttle_driver/core/utils/toast.dart';
import 'package:mmu_shuttle_driver/features/announcement/providers/announcement_provider.dart';
import 'package:mmu_shuttle_driver/features/announcement/providers/file_provider.dart';
import 'package:mmu_shuttle_driver/features/authentication/models/login_request_model.dart';
import 'package:mmu_shuttle_driver/features/authentication/providers/auth_provider.dart';
import 'package:mmu_shuttle_driver/features/authentication/services/auth_service.dart';
import 'package:mmu_shuttle_driver/core/routing/app_router.dart';
import 'package:mmu_shuttle_driver/features/routes/providers/route_provider.dart';
import 'package:provider/provider.dart';

final Dio dio = _setupDio();

Dio _setupDio() {
  final instance = Dio(
    BaseOptions(
      baseUrl: API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  instance.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = TokenManager.accessToken;

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (SESSION_EXPIRED_MESSAGE == e.response?.data['message']) {
          final authService = AuthService();
          try {
            LoginRequestModel loginRequestModel = await authService
                .loadCredentialsFromStorage();
            await authService.signIn(loginRequestModel);
            final retryResponse = await instance.fetch(e.requestOptions);

            return handler.resolve(retryResponse);
          } catch (refreshError) {
            final context = rootNavigatorKey.currentContext;
            print('"Refresh Token Error: $refreshError');
            if (context != null && context.mounted) {
              showErrorToast(context, refreshError.toString());
            }
            try {
              await authService.signOut();
            } catch (signOutError) {
              print('Sign out storage error: $signOutError');
            } finally {
              if (context != null && context.mounted) {
                context.read<RouteProvider>().clearData();
                context.read<AuthProvider>().clearData();
                context.read<FileProvider>().clearData();
                context.read<AnnouncementProvider>().clearData();
                context.go('/sign-in');
              }
            }
          }
        }

        return handler.next(e);
      },
    ),
  );

  return instance;
}
