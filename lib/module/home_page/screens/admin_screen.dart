import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/module/home_page/bloc/home_bloc.dart';
import 'package:smart_locker/module/home_page/bloc/home_event.dart';
import 'package:smart_locker/module/home_page/bloc/home_state.dart';
import 'package:smart_locker/module/home_page/screens/locker_management_page.dart';
import 'package:smart_locker/module/home_page/screens/search_order_page.dart';
import 'package:smart_locker/module/home_page/screens/user_management_page.dart';
import 'package:smart_locker/module/profile/profile/screens/profile_admin.dart';
import 'package:smart_locker/module/profile/profile/screens/profile_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text("Admin"),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                // context.router.push(ProfileRoute());

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileAdmin()),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 40,
                child: Image.asset("assets/images/avata.png"),
              ),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeChangePage) {
              return IndexedStack(
                index: state.index,
                children: [
                  UserManagementPage(),
                  LockerManagementPage(),
                  SearchOrderPage(),
                  // VideoHistoryPage(),
                ],
              );
            }
            return UserManagementPage();
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            int currentIndex = (state is HomeChangePage) ? state.index : 0;
            return BottomNavigationBar(
              selectedItemColor: Colors.redAccent,
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<HomeBloc>().add(ChangePage(index: index));
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.window),
                  label: "Lockers",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
