import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:smart_locker/module/auth/sign_in/screens/create_account_screen.dart';

@RoutePage()
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;
  int index = 0;
  List<XFile> pictures = [];
  List<String> listTitle = [
    "Take a front-facing photo",
    "Take a slightly right-angled photo",
    "Take a slightly left-angled photo",
    "Take a photo with a slight downward tilt of the head",
    "Take a photo with a slight upward tilt of the head",
    "Finish"
  ];

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.max);
    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized || _controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                    aspectRatio: _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 400,
                decoration: ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(color: Colors.greenAccent, width: 5),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Step ${index + 1} of 5",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: Text(
                          listTitle[index],
                          key: ValueKey(index),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () async {
              final picture = await _controller!.takePicture();
              // Gal.putImage(picture.path);
              pictures.add(picture);
              setState(() {
                index++;
              });

              if (index == 5) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CreateAccountScreen(pictures: pictures),
                  ),
                );
              }
            },
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.camera),
          ),
        ),
      ),
    );
  }
}
