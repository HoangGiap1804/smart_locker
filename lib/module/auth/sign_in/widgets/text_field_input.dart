import 'package:flutter/material.dart';
import 'package:smart_locker/models/shared/app_theme.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(  
        hintText: hintText,
        hintStyle: AppTheme.textfield.bodyMedium,
        prefixIcon: Icon(icon, color: Colors.black45),
        filled: true,
        fillColor: const Color(0xFFedf0f8),
        enabledBorder: OutlineInputBorder(  
          borderSide: const BorderSide(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(  
          borderSide: const BorderSide(width: 2, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
