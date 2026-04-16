import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmu_shuttle_driver/features/announcement/providers/file_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ViewFileScreen extends StatefulWidget {
  final String fileName;

  const ViewFileScreen({super.key, required this.fileName});

  @override
  State<ViewFileScreen> createState() => _ViewFileScreenState();
}

class _ViewFileScreenState extends State<ViewFileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        context.read<FileProvider>().getFile(fileName: widget.fileName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.fileName,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<FileProvider>(
        builder: (context, fileProvider, child) {
          final file = fileProvider.file;
          final isLoading = fileProvider.isLoading;
          final errorMessage = fileProvider.errorMessage;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (file == null) {
            return Center(
              child: Text(
                errorMessage ?? "File is empty or failed to load.",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (file.path.endsWith('.svg')) {
            return Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: SvgPicture.file(file),
              ),
            );
          }

          return PhotoView(
            imageProvider: FileImage(file),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text(
                  errorMessage ?? "Failed to load image",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
