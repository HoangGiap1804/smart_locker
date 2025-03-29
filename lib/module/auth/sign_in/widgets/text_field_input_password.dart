import 'package:flutter/material.dart';
import 'package:smart_locker/models/shared/app_theme.dart';

class TextFieldInputPassword extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const TextFieldInputPassword({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  State<TextFieldInputPassword> createState() => _TextFieldInputPasswordState();
}

class _TextFieldInputPasswordState extends State<TextFieldInputPassword> {

  bool _showPassWord = false;

  void set(){
    setState(() {
      _showPassWord = !_showPassWord;     
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: !_showPassWord,
      onChanged: widget.onChanged,
      decoration: InputDecoration(  
        hintText: widget.hintText,
        hintStyle: AppTheme.textfield.bodyMedium,
        prefixIcon: Icon(widget.icon, color: Colors.black45),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        border: InputBorder.none,
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
