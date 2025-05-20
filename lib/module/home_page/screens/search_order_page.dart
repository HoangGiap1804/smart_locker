import 'package:flutter/material.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';

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

  Future<void> _searchOrder() async {
    final orderId = _controller.text.trim();
    if (orderId.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final id = int.tryParse(orderId);
      if (id != null) {
        final detail = await LockerRepository(ApiService()).fetchProductHistoryDetail(id);
        if (detail != null) {
          setState(() => _result = detail);
        } else {
          setState(() => _errorMessage = "Order not found.");
        }
      } else {
        setState(() => _errorMessage = "Invalid order ID.");
      }
    } catch (e) {
      setState(() => _errorMessage = "An error occurred: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Order")),
      body: Padding(
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
                child: SingleChildScrollView(
                  child: _buildResultCard(_result!),
                ),
              ),
          ],
        ),
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
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildResultCard(ProductHistoryDetail detail) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("📦 Order Information", [
              _buildKeyValue("Order ID", detail.orderId.toString()),
              _buildKeyValue("Status", detail.status),
              _buildKeyValue("Created At", detail.createdAt.toString()),
              _buildKeyValue("Updated At", detail.updatedAt.toString()),
            ]),
            const SizedBox(height: 16),
            _buildSection("👤 User Information", [
              _buildKeyValue("Full Name", detail.user.fullname),
              _buildKeyValue("Email", detail.user.email),
              _buildKeyValue("Phone", detail.user.phone),
            ]),
            const SizedBox(height: 16),
            _buildSection("🔐 Locker Information", [
              _buildKeyValue("Locker Code", detail.lockerInfo.lockerCode),
              _buildKeyValue("Locker Status", detail.lockerInfo.status),
            ]),
            const SizedBox(height: 16),
            _buildSection("🎥 Video", [
              Text(
                detail.videoPath != null
                    ? "📹 Video attached (see on detail page)"
                    : "📹 No video available",
                style: const TextStyle(fontSize: 16),
              ),
            ]),
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
          Text(
            "$key: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
