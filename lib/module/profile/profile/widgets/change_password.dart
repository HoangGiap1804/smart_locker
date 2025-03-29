import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  final VoidCallback onTap;
  const ChangePassword({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(  
      alignment: Alignment.centerRight,
      child: InkWell( 
        onTap: onTap,
        child: Text(
          "Change Password",
          style: AppTheme.textInk.bodyLarge,
        )
      )
    );
  }
}
