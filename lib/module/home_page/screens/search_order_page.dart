import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SearchOrderPage extends StatefulWidget {
  const SearchOrderPage({super.key});

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final TextEditingController _controller = TextEditingController();
  ProductHistoryDetail? _result;
  bool _isLoading = false;
  String? _errorMessage;
  final dateFormat = DateFormat('HH:mm dd-MM-yyyy');

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  bool isLoadingVideo = true;
  bool isLoadingFalse = false;

  Future<void> _searchOrder() async {
    final orderId = _controller.text.trim();
    if (orderId.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final detail = await LockerRepository(
        ApiService(),
      ).searchProductHistoryDetail(orderId);
      if (!mounted) return;

      if (detail != null) {
        setState(() {
          _result = detail;
        });
        try {
          print("duong dan video ${detail.videoPath}");
          _videoPlayerController = VideoPlayerController.network(
            "http://192.168.1.53:8000${_result!.videoPath}",
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
    } catch (e) {
      setState(() => _errorMessage = "An error occurred: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Search order by ID",
              style: TextStyle(
                fontSize: 24, // To
                fontWeight: FontWeight.bold, // Đậm
                color: Colors.black87, // Màu dễ nhìn
                letterSpacing: 1.2, // Giãn chữ nhẹ
              ),
              textAlign: TextAlign.center, // Căn giữa nếu muốn
            ),
          ),
          _buildSearchInput(),
          const SizedBox(height: 20),
          if (_isLoading) const CircularProgressIndicator(),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          if (_result != null)
            Expanded(
              child: SingleChildScrollView(child: _buildResultCard(_result!)),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.done, // Hiện nút "OK" hoặc "Done"
      onSubmitted: (_) => _searchOrder(), // Gọi khi nhấn nút "Done"
      decoration: InputDecoration(
        labelText: "Enter Order ID",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: _searchOrder,
        ),
      ),
    );
  }

  String formatDateTime(DateTime dt) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dt.toLocal());
  }

  Widget _buildResultCard(ProductHistoryDetail _detail) {
    return Column(
      children: [
        buildInfoCard(
          title: '🧾 Order Info',
          children: [
            Text('Order ID: ${_detail.orderId}'),
            Text('Status: ${_detail.status}'),
            Text('Deliver: ${formatDateTime(_detail.createdAt)}'),
            Text('Receive: ${formatDateTime(_detail.updatedAt)}'),
          ],
        ),
        buildInfoCard(
          title: '👤 User Info',
          children: [
            Text('Name: ${_detail.user.fullname}'),
            Text('Email: ${_detail.user.email}'),
            Text('Phone: ${_detail.user.phone}'),
            Text('Gender: ${_detail.user.gender}'),
          ],
        ),
        buildInfoCard(
          title: '📦 Locker Info',
          children: [
            Text('Code: ${_detail.lockerInfo.lockerCode}'),
            Text('Status: ${_detail.lockerInfo.status}'),
          ],
        ),
        isLoadingVideo
            ? Center(child: CircularProgressIndicator())
            : (!isLoadingFalse)
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📹 Video',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
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
}
