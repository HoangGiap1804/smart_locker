import 'package:flutter/material.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

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
    final detail = await LockerRepository(
      ApiService(),
    ).fetchProductHistoryDetail(widget.productId);
    if (detail != null) {
      setState(() {
        _detail = detail;
      });

      // if (detail.videoUrl != null && detail.videoUrl!.isNotEmpty) {
      //   _controller = VideoPlayerController.network(detail.videoUrl!);
      //   _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      //     setState(() {});
      //     _controller!.play();
      //   });
      // }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
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
                Text('Created At: ${formatDateTime(_detail!.createdAt)}'),
                Text('Updated At: ${formatDateTime(_detail!.updatedAt)}'),
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
            if (_controller != null && _initializeVideoPlayerFuture != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📹 Video',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            ),
                            const SizedBox(height: 10),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _controller!.value.isPlaying
                                      ? _controller!.pause()
                                      : _controller!.play();
                                });
                              },
                              child: Icon(
                                _controller!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              )
            else
              const Text('❌ No video available.'),
          ],
        ),
      ),
    );
  }
}
