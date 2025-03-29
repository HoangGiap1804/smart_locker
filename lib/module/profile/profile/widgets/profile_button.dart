import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onTab;
  final String text;
  const ProfileButton({
    super.key,
    required this.onTab, 
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.redAccent,
        ),
        child: Text(  
          text,
          style: TextStyle( 
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ),
    );
  }
}
