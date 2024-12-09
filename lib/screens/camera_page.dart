import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _selectedCameraIndex = 0;
    await _setupCamera(_cameras[_selectedCameraIndex]);
  }

  Future<void> _setupCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _switchCamera() async {
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _setupCamera(_cameras[_selectedCameraIndex]);
  }

  Future<void> _captureAndSavePicture() async {
    try {
      await _initializeControllerFuture;

      final XFile picture = await _controller.takePicture();

      final Uint8List bytes = await File(picture.path).readAsBytes();

      final result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80,
        name: "captured_image_${DateTime.now().millisecondsSinceEpoch}",
      );

      print("Saved to gallery: $result");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Picture saved to gallery!')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: FloatingActionButton(
                    heroTag: "switchCamera",
                    onPressed: _switchCamera,
                    child: const Icon(Icons.flip_camera_android),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureAndSavePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
