import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/module/camera/camera/screens/camera_screen.dart';
import 'package:smart_locker/module/home_page/bloc/home_bloc.dart';
import 'package:smart_locker/module/home_page/bloc/home_event.dart';
import 'package:smart_locker/module/home_page/bloc/home_state.dart';
import 'package:smart_locker/module/home_page/screens/home_page.dart';
import 'package:smart_locker/module/home_page/screens/locker_management_page.dart';
import 'package:smart_locker/module/home_page/screens/search_order_page.dart';
import 'package:smart_locker/module/home_page/screens/search_package_page.dart';
import 'package:smart_locker/module/home_page/screens/user_management_page.dart';
import 'package:smart_locker/module/profile/profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return homeAdmin();
  }

  Widget homeAdmin() {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                // context.router.push(ProfileRoute());
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
                  SearchOrderPage()
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

  Widget homeUser(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFf2f2f2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.menu),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // context.router.push(ProfileRoute());

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
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
            final index = (state is HomeChangePage) ? state.index : 0;
            return getPage(index);
            // if (state is HomeChangePage) {
            // return IndexedStack(
            //   index: state.index,
            //   children: [
            //     HomePage(),
            //     SearchPackagePage(),
            //     // CameraScreen(),
            //   ],
            // );
            // }
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

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return SearchPackagePage();
      default:
        return HomePage();
    }
  }
}
