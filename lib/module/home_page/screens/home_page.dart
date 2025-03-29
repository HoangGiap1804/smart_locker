import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:smart_locker/module/home_page/widgets/package.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          Text("Your Packages", style: AppTheme.textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Package(),
          ),
        ],
      ),

    );
  }
}


