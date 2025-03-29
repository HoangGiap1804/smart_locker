import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_locker/models/shared/app_theme.dart';

class ForgotPassword extends StatefulWidget {
  final VoidCallback onTap;
  const ForgotPassword({super.key, required this.onTap});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: widget.onTap,
        child: Text("Forgot Password?", style: AppTheme.textInk.bodyLarge),
      ),
    );
  }
}
