import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required String message,
  required String cancelText,
  required String confirmText,
  required VoidCallback onCancel,
  required VoidCallback onConfirm,
  IconData icon = Icons.error_outline,
  Color backgroundColor = const Color(0xFF1C1E23),
  Color accentColor = const Color(0xFFE85A4F),
}) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Circle
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            SizedBox(height: 20),
            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onCancel();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: accentColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    cancelText,
                    style: TextStyle(color: accentColor),
                  ),
                ),
                // Confirm
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    confirmText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
