import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:better_player/better_player.dart';

class SearchOrderPage extends StatefulWidget {
  const SearchOrderPage({super.key});

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final TextEditingController _controller = TextEditingController();
  BetterPlayerController? _betterPlayerController;
  ProductHistoryDetail? _result;
  bool _isLoading = false;
  String? _errorMessage;
  final dateFormat = DateFormat('HH:mm dd-MM-yyyy');

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
      if (detail != null) {
        setState(() {
          _result = detail;

          if (_result!.videoPath != null && _result!.videoPath!.isNotEmpty) {
            _betterPlayerController = BetterPlayerController(
              const BetterPlayerConfiguration(
                autoPlay: false,
                looping: false,
                controlsConfiguration: BetterPlayerControlsConfiguration(
                  enableSkips: false,
                  enableOverflowMenu: false,
                ),
              ),
              betterPlayerDataSource: BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                _result!.videoPath!,
              ),
            );
          }
        });
      } else {
        setState(() => _errorMessage = "Order not found.");
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
    _betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
        if (_betterPlayerController != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '📹 Video',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(controller: _betterPlayerController!),
              ),
            ],
          )
        else
          const Text('❌ No video available.'),
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

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$key: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
