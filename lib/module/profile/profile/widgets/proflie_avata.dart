import 'package:flutter/material.dart';

class ProflieAvata extends StatelessWidget {
  final String pathIcon;
  const ProflieAvata({super.key, required this.pathIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: Card(
        borderOnForeground: false,
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        shape: const CircleBorder(),
        child: Image.asset(pathIcon, scale: 0.2),
      ),
    );
  }
}
