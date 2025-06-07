import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_locker/module/home_page/widgets/notification_message.dart';
import 'package:smart_locker/repositories/order_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

class FaceScan extends StatefulWidget {
  final String idPackage;
  const FaceScan({super.key, required this.idPackage});

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;
  int index = 0;
  List<XFile> pictures = [];
  String title = "Scan Face";
  bool isLoading = false;

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
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (child, animation) => FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                        child: Text(
                          title,
                          key: ValueKey(index),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: SpinKitPouringHourGlassRefined(
                  color: Colors.greenAccent,
                  size: 50.0,
                ),
              ),
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
              try {
                if (isLoading) return;
                setState(() {
                  isLoading = true;
                });
                XFile picture = await _controller!.takePicture();
                print("📸 Picture taken: ${picture.path}");

                String? accessToken = await StorageService().getAccessToken();
                if (accessToken != null) {
                  bool? set = await OrderRepository(
                    ApiService(),
                  ).scanFace(widget.idPackage, picture, accessToken);

                  if (set == null || !set) {
                    NotificationMessage().notify(context, "False");
                  } else {
                    NotificationMessage().notify(context, "Success");
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.pop(context);
                    });
                  }
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  print("⚠️ Access token is null");
                }
              } catch (e) {
                print("❌ Error when taking picture or calling API: $e");
                NotificationMessage().notify(context, "Error: $e");
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
