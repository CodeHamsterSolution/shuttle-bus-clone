import 'package:flutter/material.dart';

class ViewFileWidget extends StatelessWidget {
  final String fileName;
  final VoidCallback? onView;

  const ViewFileWidget({
    super.key,
    required this.fileName,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onView,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.insert_drive_file,
              color: const Color(0xFF003399),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                fileName,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.attachment, color: Colors.grey.shade600, size: 20),
          ],
        ),
      ),
    );
  }
}
