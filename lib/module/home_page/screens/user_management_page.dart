import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_locker/models/user_model.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  Widget build(BuildContext context) {
    List<UserModel> listUser = UserModel.listUser(20);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: SearchBar(
            leading: Icon(Icons.search),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listUser.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(listUser[index]),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor:
                          (listUser[index].paid)
                              ? Colors.redAccent
                              : Colors.greenAccent,
                      foregroundColor: Colors.white,
                      icon:
                          (listUser[index].paid) ? Icons.lock : Icons.lock_open,
                      label: (listUser[index].paid) ? "Close" : "Open",
                    ),
                  ],
                ),
                child: Container(
                  color:
                      (listUser[index].paid) ? Colors.white : Colors.redAccent,
                  child: ListTile(
                    onTap: () {},
                    leading: listUser[index].image,
                    title: Text('Name: ${listUser[index].name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone number: ${listUser[index].phoneNumber}'),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
