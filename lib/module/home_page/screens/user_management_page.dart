import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_locker/models/user_active.dart';
import 'package:smart_locker/repositories/user_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

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
    _futureUsers = UserRepository(ApiService()).getAllUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: SearchBar(
            leading: Icon(Icons.search),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<UserActive>>(
            future: _futureUsers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final users = snapshot.data!;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Slidable(
                    key: ValueKey(user.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            // TODO: Toggle user status
                            bool set = await UserRepository(ApiService()).toggleUserActive(user.id, !user.isActive);
                            if(set){
                              setState(() {
                                _futureUsers = UserRepository(ApiService()).getAllUsers();
                              });
                            }
                          },
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
                    child: Container(
                      color: user.isActive ? Colors.white : Colors.redAccent,
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Username: ${user.username}'),
                        subtitle: Text('Email: ${user.email}'),
                        trailing: Text(user.isActive ? 'Active' : 'Inactive'),
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
