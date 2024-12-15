import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class CameraService {
  CameraController? _controller;
  late List<CameraDescription> _cameras;
  int _selectedCameraIndex = 0;

  Future<void> initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _selectedCameraIndex = 0;
      await _setupCamera(_cameras[_selectedCameraIndex]);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error initializing camera: $e");
    }
  }

  Future<void> _setupCamera(CameraDescription camera) async {
    try {
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );
      await _controller!.initialize();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error setting up camera: $e");
    }
  }

  Future<void> switchCamera() async {
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _setupCamera(_cameras[_selectedCameraIndex]);
  }

  Future<String?> captureAndSavePicture() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        throw Exception("Camera is not initialized.");
      }

      final XFile picture = await _controller!.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File savedImage = File(imagePath)
        ..writeAsBytesSync(await picture.readAsBytes());
      final result = await ImageGallerySaver.saveFile(savedImage.path);

      if (result['isSuccess']) {
        return savedImage.path;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error capturing picture: $e");
      return null;
    }
  }

  Future<String?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  CameraController? get controller => _controller;
}
