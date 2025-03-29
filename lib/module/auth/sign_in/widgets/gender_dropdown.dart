import 'package:flutter/material.dart';
import 'package:smart_locker/models/shared/app_theme.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final IconData icon;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTheme.textfield.bodyMedium,
        prefixIcon: Icon(icon, color: Colors.black45),
        filled: true,
        fillColor: const Color(0xFFedf0f8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black45),
      borderRadius: BorderRadius.circular(10),
      style: AppTheme.textfield.bodyMedium,
      items: items.map((item) => _buildDropdownItem(item)).toList(),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
