import 'package:flutter/material.dart';
import 'package:smart_locker/core/app/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_locker/module/home_page/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
