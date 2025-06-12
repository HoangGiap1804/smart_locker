import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  const SearchField({super.key, required this.controller, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 40,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          controller: controller,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            hintText: "Search your Packages",
            hintStyle: AppTheme.textfield.bodyMedium,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.search),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
