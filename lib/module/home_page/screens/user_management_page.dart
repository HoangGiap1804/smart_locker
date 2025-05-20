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

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    _futureUsers = UserRepository(ApiService()).getAllUsers();
  }

  Future<void> _toggleUserStatus(UserActive user) async {
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
        const Padding(
          padding: EdgeInsets.all(12),
          child: SearchBar(
            leading: Icon(Icons.search),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            hintText: 'Search by username...',
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

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Slidable(
                    key: ValueKey(user.id),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) => _toggleUserStatus(user),
                          backgroundColor:
                              user.isActive
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                          foregroundColor: Colors.white,
                          icon: user.isActive ? Icons.lock : Icons.lock_open,
                          label: user.isActive ? 'Deactivate' : 'Activate',
                        ),
                      ],
                    ),
                    child: Card(
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
                          user.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(user.email),
                        trailing: Chip(
                          label: Text(user.isActive ? 'Active' : 'Inactive'),
                          backgroundColor:
                              user.isActive
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                          labelStyle: const TextStyle(color: Colors.white),
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
