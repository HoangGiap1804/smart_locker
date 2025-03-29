import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final VoidCallback onTab;
  final String text;

  const Button({
    super.key,
    required this.onTab,
    required this. text,
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
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        )
      ),
    );
  }
}
