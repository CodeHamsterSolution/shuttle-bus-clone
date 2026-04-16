import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/core/widgets/error_label.dart';
import 'package:mmu_shuttle_driver/core/widgets/header.dart';
import 'package:mmu_shuttle_driver/features/routes/models/route_model.dart';
import 'package:mmu_shuttle_driver/features/routes/providers/route_provider.dart';
import 'package:mmu_shuttle_driver/features/routes/widgets/route_card.dart';
import 'package:mmu_shuttle_driver/features/routes/widgets/skeleton.dart';
import 'package:provider/provider.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  //methods
  void _onTap(BuildContext context, RouteModel route) {
    final routeProvider = context.read<RouteProvider>();
    routeProvider.selectRoute(route);
    context.push('/start-route');
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<RouteProvider>().fetchRoutes();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        child: Column(
          children: [
            HeaderWidget(
              title: 'My Routes',
              subtitle: 'Select a route to start pickup',
            ),
            SizedBox(height: 25),
            Consumer<RouteProvider>(
              builder: (context, routeProvider, child) {
                //passed value
                final routes = routeProvider.routes;
                final isLoading = routeProvider.isLoading;
                final errorMessage = routeProvider.errorMesssage;

                if (isLoading) {
                  return Column(
                    children: List.generate(3, (index) {
                      return const Column(
                        children: [SkeletonWidget(), SizedBox(height: 10)],
                      );
                    }),
                  );
                }

                if (errorMessage != null) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      ErrorLabelWidget(
                        errorMessage: errorMessage,
                        onRetry: () {
                          routeProvider.fetchRoutes();
                        },
                      ),
                    ],
                  );
                }

                if (routes.isEmpty) {
                  return Center(
                    child: Text(
                      'No routes found',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  );
                }

                return Column(
                  children: routes.map((route) {
                    return Column(
                      children: [
                        RouteCardWidget(
                          routeName: route.routeName,
                          stationCount: route.totalStations,
                          onTap: () => _onTap(context, route),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
