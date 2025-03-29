import 'package:flutter/material.dart';
import 'package:smart_locker/module/home_page/widgets/search_field.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_button.dart';

class SearchPackagePage extends StatelessWidget {
  const SearchPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchField(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ProfileButton(onTab: (){}, text: "FIND")
          ),
        ],
      ),

    );

  }
}
