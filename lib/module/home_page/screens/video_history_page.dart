import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<String> fetchVideoUrl() async {
//   final response = await http.get(
//     Uri.parse('https://vip.opstream16.com/20230114/29210_45f6d896/index.m3u8'),
//   );
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     return data['videoUrl'];
//   } else {
//     throw Exception('Failed to load video');
//   }
// }

class VideoHistoryPage extends StatefulWidget {
  const VideoHistoryPage({super.key});

  @override
  State<VideoHistoryPage> createState() => _VideoHistoryPageState();
}

class _VideoHistoryPageState extends State<VideoHistoryPage> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://vip.opstream16.com/20230114/29210_45f6d896/index.m3u8',
    );
    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      setState(() {});
      _controller!.play();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          _controller == null
              ? CircularProgressIndicator()
              : FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
    );
  }
}
