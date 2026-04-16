import 'package:flutter/material.dart';
import 'package:mmu_shuttle_driver/core/utils/toast.dart';

class TogglePinConfirmationDialog extends StatefulWidget {
  final bool isPinned;
  final Future<void> Function() onTogglePin;

  const TogglePinConfirmationDialog({
    super.key,
    required this.isPinned,
    required this.onTogglePin,
  });

  @override
  State<TogglePinConfirmationDialog> createState() =>
      _TogglePinConfirmationDialogState();
}

class _TogglePinConfirmationDialogState
    extends State<TogglePinConfirmationDialog> {
  bool _isLoading = false;

  void _handleTogglePin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.onTogglePin();
      showSuccessToast(
        context,
        widget.isPinned
            ? 'Announcement unpinned successfully'
            : 'Announcement pinned successfully',
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      showErrorToast(context, e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: widget.isPinned
                    ? Colors.grey[100]
                    : const Color(0xFFFFF8E1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
                size: 32,
                color: widget.isPinned ? Colors.grey[600] : Colors.amber[700],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.isPinned ? 'Unpin Announcement' : 'Pin Announcement',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.isPinned
                  ? 'Are you sure you want to unpin this announcement? It will no longer appear at the top.'
                  : 'Are you sure you want to pin this announcement? It will appear at the top of the list.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleTogglePin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isPinned
                          ? Colors.grey[200]
                          : const Color(0xFF003399),
                      foregroundColor: widget.isPinned
                          ? Colors.black87
                          : Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: widget.isPinned
                                  ? Colors.black54
                                  : Colors.white,
                            ),
                          )
                        : Text(
                            widget.isPinned ? 'Unpin' : 'Pin',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
