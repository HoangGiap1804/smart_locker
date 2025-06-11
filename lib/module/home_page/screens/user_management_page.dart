import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_locker/models/user_active.dart';
import 'package:smart_locker/repositories/user_repository.dart';
import 'package:smart_locker/services/api_service.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  late Future<List<UserActive>> _futureUsers;
  final TextEditingController controllSearch = TextEditingController();
  int? _isLoadingUserId;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    _futureUsers = UserRepository(ApiService()).getAllUsers();
    _isLoadingUserId = null;
  }

  Future<void> _toggleUserStatus(UserActive user) async {
    setState(() {
      _isLoadingUserId = user.id; // Bắt đầu loading cho người dùng này
    });
    bool success = await UserRepository(
      ApiService(),
    ).toggleUserActive(user.id, !user.isActive);
    if (success) {
      setState(() => _loadUsers());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "User Manager",
            style: TextStyle(
              fontSize: 24, // To
              fontWeight: FontWeight.bold, // Đậm
              color: Colors.black87, // Màu dễ nhìn
              letterSpacing: 1.2, // Giãn chữ nhẹ
            ),
            textAlign: TextAlign.center, // Căn giữa nếu muốn
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SearchBar(
            controller: controllSearch,
            leading: Icon(Icons.search),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            hintText: 'Search by name or phone',
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<List<UserActive>>(
            future: _futureUsers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final users = snapshot.data ?? [];

              if (users.isEmpty) {
                return const Center(child: Text('No users found.'));
              }
              List<UserActive> listSearch;
              (controllSearch.text.isNotEmpty)
                  ? listSearch =
                      users
                          .where(
                            (user) =>
                                user.fullName.toLowerCase().contains(
                                  controllSearch.text.toLowerCase(),
                                ) ||
                                user.phone.toLowerCase().contains(
                                  controllSearch.text.toLowerCase(),
                                ),
                          )
                          .toList()
                  : listSearch = users;

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: listSearch.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = listSearch[index];

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            user.isActive
                                ? Colors.greenAccent
                                : Colors.redAccent,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        user.fullName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(user.phone),
                      trailing: InkWell(
                        onTap: () {
                          _toggleUserStatus(user);
                        },
                        child:
                            (_isLoadingUserId == user.id)
                                ? const SizedBox(
                                  width:
                                      24, // Kích thước của CircularProgressIndicator
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                : Chip(
                                  label: Text(
                                    user.isActive ? 'Active' : 'Inactive',
                                  ),
                                  backgroundColor:
                                      user.isActive
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
