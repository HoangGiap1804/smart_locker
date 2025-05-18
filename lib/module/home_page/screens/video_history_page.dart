import 'package:flutter/material.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:video_player/video_player.dart';

class VideoHistoryPage extends StatefulWidget {
  final int productId;

  const VideoHistoryPage({super.key, required this.productId});

  @override
  State<VideoHistoryPage> createState() => _VideoHistoryPageState();
}

class _VideoHistoryPageState extends State<VideoHistoryPage> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  ProductHistoryDetail? _detail;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    final detail = await LockerRepository(ApiService()).fetchProductHistoryDetail(widget.productId);
    if (detail != null) {
      setState(() {
        _detail = detail;
      });
        // _controller = VideoPlayerController.network('https://vip.opstream16.com/20230114/29210_45f6d896/index.m3u8');
        // _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
        //   setState(() {});
        //   _controller!.play();
        // });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_detail == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text('Product History Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🧾 Order ID: ${_detail!.orderId}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('📦 Status: ${_detail!.status}'),
            Text('📅 Created At: ${_detail!.createdAt}'),
            Text('🔄 Updated At: ${_detail!.updatedAt}'),
            const SizedBox(height: 12),

            Text('👤 User Info:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('  Name: ${_detail!.user.fullname}'),
            Text('  Email: ${_detail!.user.email}'),
            Text('  Phone: ${_detail!.user.phone}'),
            Text('  Gender: ${_detail!.user.gender}'),
            const SizedBox(height: 12),

            Text('📦 Locker Info:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('  Code: ${_detail!.lockerInfo.lockerCode}'),
            Text('  Status: ${_detail!.lockerInfo.status}'),
            const SizedBox(height: 20),

            // if (_controller != null)
            //   FutureBuilder(
            //     future: _initializeVideoPlayerFuture,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         return AspectRatio(
            //           aspectRatio: _controller!.value.aspectRatio,
            //           child: VideoPlayer(_controller!),
            //         );
            //       } else {
            //         return const CircularProgressIndicator();
            //       }
            //     },
            //   )
            // else
            //   const Text('📹 No video available.'),
          ],
        ),
      ),
    );
  }
}
