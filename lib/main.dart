import 'package:flutter/material.dart';
import 'package:smart_locker/module/auth/sign_in/screens/login_screen.dart';
import 'package:smart_locker/module/home_page/screens/home_screen.dart';
import 'package:smart_locker/services/storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final appRouter = AppRouter();
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   routerConfig: appRouter.config(),
    // );
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home:
    //       (StorageService().getAccessToken() == "")
    //           ? LoginScreen()
    //           : HomeScreen(),
    // );
  }
}
