import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/core/utils/date.dart';
import 'package:mmu_shuttle_driver/core/widgets/error_label.dart';
import 'package:mmu_shuttle_driver/core/widgets/header.dart';
import 'package:mmu_shuttle_driver/features/announcement/providers/announcement_provider.dart';
import 'package:mmu_shuttle_driver/features/announcement/widgets/announcement_card.dart';
import 'package:mmu_shuttle_driver/features/announcement/widgets/toggle_pin_confirmation_dialog.dart';
import 'package:mmu_shuttle_driver/features/announcement/widgets/create_announcement_dialog.dart';
import 'package:mmu_shuttle_driver/core/widgets/custom_floating_button.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  //methods
  Future<void> _onTogglePin(BuildContext context, int id) async {
    //initiate variables
    final announcementProvider = context.read<AnnouncementProvider>();

    await announcementProvider.togglePin(id);
  }

  void _onView(BuildContext context, String fileName) {
    context.push('/view-file', extra: fileName);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        context.read<AnnouncementProvider>().fetchAnnouncements();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Consumer<AnnouncementProvider>(
            builder: (context, announcementProvider, child) {
              //pass values
              final announcements = announcementProvider.announcements;
              final isLoading = announcementProvider.isLoading;
              final errorMessage = announcementProvider.errorMessage;

              if (isLoading == true) {
                return const Center(child: CircularProgressIndicator());
              }

              if (errorMessage != null) {
                return Center(
                  child: ErrorLabelWidget(
                    errorMessage: errorMessage,
                    onRetry: () {
                      context.read<AnnouncementProvider>().fetchAnnouncements();
                    },
                  ),
                );
              }

              if (announcements.isEmpty) {
                return Center(
                  child: Text(
                    'No announcements found',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    HeaderWidget(
                      title: 'Announcements',
                      subtitle: 'Manage and create announcements',
                    ),
                    SizedBox(height: 25),
                    ...announcements.map((announcement) {
                      return Column(
                        children: [
                          AnnouncementCardWidget(
                            title: announcement.title,
                            description: announcement.description,
                            createdAt: formatAnnouncementDate(
                              announcement.createdAt.toString(),
                            ),
                            isPinned: announcement.isPinned,
                            fileName: announcement.fileName,
                            onTogglePin: () => showDialog(
                              context: context,
                              builder: (context) => TogglePinConfirmationDialog(
                                isPinned: announcement.isPinned,
                                onTogglePin: () =>
                                    _onTogglePin(context, announcement.id),
                              ),
                            ),
                            onView: announcement.fileName != null
                                ? () => _onView(context, announcement.fileName!)
                                : null,
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: CustomAddButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CreateAnnouncementDialog(),
              );
            },
          ),
        ),
      ],
    );
  }
}
