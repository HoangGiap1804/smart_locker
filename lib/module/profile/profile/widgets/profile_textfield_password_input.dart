import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileTextfieldPasswordInput extends StatefulWidget {
  final TextEditingController textEditingController;
  const ProfileTextfieldPasswordInput({
    super.key,
    required this.textEditingController,
  });

  @override
  State<ProfileTextfieldPasswordInput> createState() => _ProfileTextfieldPasswordInputState();
}

class _ProfileTextfieldPasswordInputState extends State<ProfileTextfieldPasswordInput> {
  bool _showPassWord = false;

  void set(){
    setState(() {
      _showPassWord = !_showPassWord;     
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: !_showPassWord,
      readOnly: true,
      decoration: InputDecoration(  
        hintText: "password",
        hintStyle: AppTheme.textfield.bodyMedium,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(  
          borderSide: const BorderSide(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(  
          borderSide: const BorderSide(width: 2, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: !_showPassWord ? 
        IconButton(
          onPressed: (){
            set();
          }, 
          icon: Icon(Icons.remove_red_eye)
        ) : 
        IconButton(
          onPressed: (){
            set();
          }, 
          icon: Icon(Icons.remove_red_eye_outlined)
        ),
      ),
    );
  }
}
