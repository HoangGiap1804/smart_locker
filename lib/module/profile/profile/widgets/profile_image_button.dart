import 'package:flutter/material.dart';

class ProfileImageButton extends StatelessWidget {
  final VoidCallback onTab;
  final String pathIcon;
  const ProfileImageButton({
    super.key,
    required this.onTab,
    required this.pathIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide( 
              color: Colors.white,
              width: 7,
            ),
          ),
        ),
        child: Card(  
          borderOnForeground: false,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(0),
          color: Colors.white,
          shape: const CircleBorder(  
          ),
          child: Container( 
            width: 50,
            height: 50,
            color: Colors.blue,
            child: Icon(Icons.pending, color: Colors.white,),
          ),
        )
      ),
    );
  }
}
