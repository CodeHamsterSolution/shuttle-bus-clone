import 'package:flutter/material.dart';
import 'package:mmu_shuttle_driver/core/widgets/custom_elevated_button.dart';

class StartRouteCard extends StatelessWidget {
  final String title;
  final String totalStation;
  final bool isOngoing;
  final bool isLoading;
  final VoidCallback? onStartJourney;
  final VoidCallback? onSendUpdate;
  final VoidCallback? onStopJourney;

  const StartRouteCard({
    super.key,
    required this.title,
    required this.totalStation,
    this.onStartJourney,
    this.onSendUpdate,
    this.onStopJourney,
    required this.isOngoing,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              totalStation,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: isOngoing
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: onSendUpdate,
                            icon: const Icon(
                              Icons.send_outlined,
                              color: Color(0xFF0084FF),
                            ),
                            label: const Text(
                              "Send Route Update",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0084FF),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Colors.grey.shade400),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : onStopJourney,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEA4335),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Stop Journey",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )
                  : CustomElevatedButton(
                      onPressed: onStartJourney,
                      text: 'Start Journey',
                      isLoading: isLoading,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
