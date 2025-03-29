import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileTextfieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String header;
  const ProfileTextfieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Text(
          header,
          style: AppTheme.textTheme.bodyLarge,
        ),
        SizedBox(height: 10,),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(  
            hintText: hintText,
            hintStyle: AppTheme.textfield.bodyMedium,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(  
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(  
              borderSide: const BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
