import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/core/authentication/token_manager.dart';
import 'package:mmu_shuttle_driver/core/routing/route_navigation_helper.dart';
import 'package:mmu_shuttle_driver/features/authentication/services/auth_service.dart';
import 'package:mmu_shuttle_driver/features/main_navigation/widgets/pulse_loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await _checkIsLoggedIn();
    }
  }

  Future<void> _checkIsLoggedIn() async {
    final authService = AuthService();
    await authService.loadToken();
    String? token = TokenManager.accessToken;
    if (token == null || token.isEmpty) {
      context.go('/sign-in');
    } else {
      await RouteNavigationHelper.checkAndNavigateActiveRoute(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF60A5FA),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.directions_bus_rounded,
                      size: 70,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  builder: (context, value, child) {
                    return Opacity(opacity: value, child: child);
                  },
                  child: Column(
                    children: [
                      Text(
                        'MMU Shuttle Bus',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 60),

                const PulseLoadingIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Initializing...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
