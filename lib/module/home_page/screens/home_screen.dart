import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/module/home_page/bloc/home_bloc.dart';
import 'package:smart_locker/module/home_page/bloc/home_event.dart';
import 'package:smart_locker/module/home_page/bloc/home_state.dart';
import 'package:smart_locker/module/home_page/screens/home_page.dart';
import 'package:smart_locker/module/home_page/screens/search_package_page.dart';
import 'package:smart_locker/module/profile/profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [const HomePage(), const SearchPackagePage()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          int currentIndex = (state is HomeChangePage) ? state.index : 0;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Smart Locker",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black87),
                onPressed: () {
                  // Handle menu action
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/images/avata.png"),
                    ),
                  ),
                ),
              ],
            ),
            body: IndexedStack(index: currentIndex, children: _pages),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<HomeBloc>().add(ChangePage(index: index));
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
