import 'package:flutter/material.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart'; // giả định bạn có service
import 'package:video_player/video_player.dart'; // nếu cần dùng video

class SearchOrderPage extends StatefulWidget {
  const SearchOrderPage({super.key});

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final TextEditingController _controller = TextEditingController();
  ProductHistoryDetail? _result;
  bool _isLoading = false;
  String? _error;

  Future<void> _searchOrder() async {
    final orderIdText = _controller.text.trim();
    if (orderIdText.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _result = null;
    });

    try {
      if (int.tryParse(orderIdText) != null) {
        final detail = await LockerRepository(
          ApiService(),
        ).fetchProductHistoryDetail(int.parse(orderIdText));
        if (detail != null) {
          setState(() => _result = detail);
        } else {
          setState(() => _error = "Không tìm thấy đơn hàng");
        }
      }
    } catch (e) {
      setState(() => _error = "Đã xảy ra lỗi: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tìm kiếm đơn hàng")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Nhập mã đơn hàng",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchOrder,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading) CircularProgressIndicator(),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            if (_result != null) _buildResultWidget(_result!),
          ],
        ),
      ),
    );
  }

  Widget _buildResultWidget(ProductHistoryDetail detail) {
    return Expanded(
      child: ListView(
        children: [
          Text(
            '🧾 Order ID: ${detail.orderId}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('📦 Status: ${detail.status}'),
          Text('📅 Created At: ${detail.createdAt}'),
          Text('🔄 Updated At: ${detail.updatedAt}'),
          const SizedBox(height: 12),
          Text('👤 Fullname: ${detail.user.fullname}'),
          Text('📧 Email: ${detail.user.email}'),
          Text('📱 Phone: ${detail.user.phone}'),
          const SizedBox(height: 12),
          Text('📦 Locker Code: ${detail.lockerInfo.lockerCode}'),
          Text('📦 Locker Status: ${detail.lockerInfo.status}'),
          const SizedBox(height: 12),
          detail.videoPath != null
              ? Text('📹 Có video đính kèm (xem ở trang chi tiết)')
              : Text('📹 Không có video'),
        ],
      ),
    );
  }
}
