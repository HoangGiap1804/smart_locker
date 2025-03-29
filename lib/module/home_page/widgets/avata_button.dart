import 'package:flutter/material.dart';

class AvataButton extends StatelessWidget {
  final VoidCallback onTab;
  final String pathIcon;

  const AvataButton({
    super.key,
    required this.onTab,
    required this. pathIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide( 
                color: Colors.redAccent,
                width: 1,
              ),
            ),
          ),
          child: Container( 
            padding: EdgeInsets.all(14),
            child: Image.asset(
              pathIcon,
              scale: 0.8,
            ),
          )
        ),
      ),
    );
  }
}
