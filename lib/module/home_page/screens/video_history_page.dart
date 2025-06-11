import 'package:flutter/material.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoHistoryPage extends StatefulWidget {
  final int productId;

  const VideoHistoryPage({super.key, required this.productId});

  @override
  State<VideoHistoryPage> createState() => _VideoHistoryPageState();
}

class _VideoHistoryPageState extends State<VideoHistoryPage> {
  ProductHistoryDetail? _detail;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isLoadingVideo = true;
  bool isLoadingFalse = false;
  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    final detail = await LockerRepository(
      ApiService(),
    ).fetchProductHistoryDetail(widget.productId);
    if (!mounted) return;

    if (detail != null) {
      setState(() {
        _detail = detail;
      });
      try {
        print("duong dan video ${detail.videoPath}");
        _videoPlayerController = VideoPlayerController.network(
          "http://192.168.1.53:8000${_detail!.videoPath}",
        );
        await _videoPlayerController!.initialize();

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: false,
          allowMuting: true,
          allowPlaybackSpeedChanging: true,
        );
      } catch (e) {
        setState(() {
          isLoadingFalse = true;
        });
      }

      setState(() {
        isLoadingVideo = false;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();

    super.dispose();
  }

  String formatDateTime(DateTime dt) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dt.toLocal());
  }

  Widget buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Product History Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildInfoCard(
              title: '🧾 Order Info',
              children: [
                Text('Order ID: ${_detail!.orderId}'),
                Text('Status: ${_detail!.status}'),
                Text('Deliver: ${formatDateTime(_detail!.createdAt)}'),
                Text('Receive: ${formatDateTime(_detail!.updatedAt)}'),
              ],
            ),
            buildInfoCard(
              title: '👤 User Info',
              children: [
                Text('Name: ${_detail!.user.fullname}'),
                Text('Email: ${_detail!.user.email}'),
                Text('Phone: ${_detail!.user.phone}'),
                Text('Gender: ${_detail!.user.gender}'),
              ],
            ),
            buildInfoCard(
              title: '📦 Locker Info',
              children: [
                Text('Code: ${_detail!.lockerInfo.lockerCode}'),
                Text('Status: ${_detail!.lockerInfo.status}'),
              ],
            ),
            const SizedBox(height: 10),
            isLoadingVideo
                ? Center(child: CircularProgressIndicator())
                : (!isLoadingFalse)
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📹 Video',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(controller: _chewieController!),
                    ),
                  ],
                )
                : const Text('❌ No video available.'),
          ],
        ),
      ),
    );
  }
}
