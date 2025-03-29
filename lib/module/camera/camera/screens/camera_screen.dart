import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    _controller = CameraController(frontCamera, ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    Future<void> takePicture() async {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Ảnh đã được lưu vào thư viện!")));
    }

    if (!_controller.value.isInitialized) {
      return Scaffold();
    } else {
      return Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.flip(
                flipX: true,
                child: Transform.scale(
                  scale: 2.5,
                  child: Transform.rotate(
                    angle: -3.14159 / 2,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 400,
                  decoration: ShapeDecoration(
                    shape: OvalBorder(
                      side: BorderSide(color: Colors.green, width: 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter, // Căn giữa theo chiều ngang
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ), // Điều chỉnh khoảng cách từ dưới lên
            child: FloatingActionButton(
              onPressed: () async {
                XFile picture = await _controller.takePicture();
                Gal.putImage(picture.path);
              },
              backgroundColor: Colors.white,
              shape: CircleBorder(),
              child: Icon(Icons.camera),
            ),
          ),
        ),
      );
    }
  }
}
