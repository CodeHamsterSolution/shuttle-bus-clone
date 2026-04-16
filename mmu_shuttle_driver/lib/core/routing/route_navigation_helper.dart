import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/core/authentication/token_manager.dart';
import 'package:provider/provider.dart';
import 'package:mmu_shuttle_driver/core/utils/toast.dart';
import 'package:mmu_shuttle_driver/features/routes/providers/route_provider.dart';
import 'package:mmu_shuttle_driver/features/routes/services/route_service.dart';

class RouteNavigationHelper {
  static Future<void> checkAndNavigateActiveRoute(BuildContext context) async {
    final routeService = RouteService();

    final localActiveRouteId = await routeService.getActiveRideIdFromLocal();
    if (localActiveRouteId != null && context.mounted) {
      await _initializeRoute(context, localActiveRouteId);
      return;
    }

    try {
      final serverActiveRouteId = await routeService
          .getActiveRideIdFromServer();
      if (serverActiveRouteId != null && context.mounted) {
        await _initializeRoute(context, serverActiveRouteId);
        return;
      }
    } catch (e) {
      showErrorToast(context, 'Fail to retrieve active ride information.');
    }

    if (!context.mounted) return;

    if (!_isUserStillLoggedIn()) return;

    context.go('/routes');
  }

  static Future<void> _initializeRoute(
    BuildContext context,
    int routeId,
  ) async {
    final routeProvider = context.read<RouteProvider>();
    bool isSuccess = true;

    isSuccess = await routeProvider.restoreRoutes(routeId);

    if (!context.mounted) return;

    if (!_isUserStillLoggedIn()) return;

    if (!isSuccess) {
      showErrorToast(context, 'Fail to retrieve active ride information.');
      context.go('/routes');
    } else {
      context.go('/start-route', extra: true);
    }
  }

  static bool _isUserStillLoggedIn() {
    final token = TokenManager.accessToken;
    return token != null && token.isNotEmpty;
  }
}
