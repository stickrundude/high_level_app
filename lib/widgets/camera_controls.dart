import 'package:flutter/material.dart';
import '/theme/app_theme.dart';

class CameraControls extends StatelessWidget {
  final VoidCallback onCapturePressed;
  final VoidCallback onGalleryPressed;
  final bool isCaptureActive;
  final bool isGalleryActive;

  const CameraControls({
    required this.onCapturePressed,
    required this.onGalleryPressed,
    required this.isCaptureActive,
    required this.isGalleryActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGalleryButton(),
          _buildCaptureButton(),
        ],
      ),
    );
  }

  ElevatedButton _buildGalleryButton() {
    return ElevatedButton(
      style: AppTheme.elevatedButtonWithColor(
        isGalleryActive
            ? const Color.fromARGB(255, 75, 177, 246)
            : const Color.fromARGB(255, 185, 214, 237),
      ),
      onPressed: onGalleryPressed,
      child: const Text('Open Gallery'),
    );
  }

  ElevatedButton _buildCaptureButton() {
    return ElevatedButton(
      style: AppTheme.elevatedButtonWithColor(
        isCaptureActive
            ? const Color.fromARGB(255, 75, 177, 246)
            : const Color.fromARGB(255, 185, 214, 237),
      ),
      onPressed: onCapturePressed,
      child: isCaptureActive
          ? const Icon(Icons.camera_alt, size: 30)
          : const Text('Capture'),
    );
  }
}
