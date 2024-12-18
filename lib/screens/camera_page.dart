import 'package:flutter/material.dart';
import '/widgets/camera_preview.dart';
import '/widgets/camera_controls.dart';
import '/services/camera_services.dart';
import '/widgets/background.dart';
import '/generated/l10n.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraService _cameraService;
  bool _isGalleryImageSelected = false;
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _cameraService = CameraService();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _cameraService.initializeCamera();
    setState(() {});
  }

  Future<void> _switchCamera() async {
    await _cameraService.switchCamera();
    setState(() {});
  }

  Future<void> _captureAndSavePicture() async {
    if (_isGalleryImageSelected) {
      setState(() {
        _isGalleryImageSelected = false;
      });
    } else {
      String? imagePath = await _cameraService.captureAndSavePicture();
      if (imagePath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).pictureSavedToGallery)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failedToSavePicture)),
        );
      }
      setState(() {});
    }
  }

  Future<void> _pickImageFromGallery() async {
    String? pickedFilePath = await _cameraService.pickImageFromGallery();
    if (pickedFilePath != null) {
      setState(() {
        _isGalleryImageSelected = true;
        _selectedImagePath = pickedFilePath;
      });
    }
  }

  @override
  void dispose() {
    _cameraService.controller?.dispose();
    super.dispose();
  }

  Widget _buildCameraSwitcher() {
    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 91, 91, 91).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(1.0),
        child: IconButton(
          onPressed: _switchCamera,
          icon: const Icon(Icons.flip_camera_android),
          color: Colors.white,
          iconSize: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: _cameraService.controller?.value.isInitialized == true
            ? Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 91, 91, 91),
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: CameraPreviewWidget(
                            isGalleryImageSelected: _isGalleryImageSelected,
                            selectedImagePath: _selectedImagePath,
                            controller: _cameraService.controller!,
                            containerWidth: double.infinity,
                            containerHeight: double.infinity,
                          ),
                        ),
                        if (!_isGalleryImageSelected) _buildCameraSwitcher(),
                      ],
                    ),
                  ),
                  CameraControls(
                    onCapturePressed: _captureAndSavePicture,
                    onGalleryPressed: _pickImageFromGallery,
                    isCaptureActive: !_isGalleryImageSelected,
                    isGalleryActive: _isGalleryImageSelected,
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
