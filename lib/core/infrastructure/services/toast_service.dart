import 'package:flutter/material.dart';

class ToastService {
  ToastService._();

  // Global key for accessing ScaffoldMessenger
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Show success snackbar (green)
  static void showSuccess(String message) {
    _showSnackBar(
      message,
      backgroundColor: const Color(0xFF4CAF50),
      icon: Icons.check_circle,
    );
  }

  /// Show error snackbar (red)
  static void showError(String message) {
    _showSnackBar(
      message,
      backgroundColor: const Color(0xFFF44336),
      icon: Icons.error,
      duration: const Duration(seconds: 4),
    );
  }

  /// Show warning snackbar (orange)
  static void showWarning(String message) {
    _showSnackBar(
      message,
      backgroundColor: const Color(0xFFFF9800),
      icon: Icons.warning,
    );
  }

  /// Show info snackbar (blue)
  static void showInfo(String message) {
    _showSnackBar(
      message,
      backgroundColor: const Color(0xFF2196F3),
      icon: Icons.info,
    );
  }

  static void _showSnackBar(
    String message, {
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
