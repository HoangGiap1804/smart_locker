import 'package:flutter/material.dart';
import 'package:smart_locker/models/shared/app_theme.dart';

class Package extends StatelessWidget {
  const Package({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID: aopiejfoiajefoiajefoi",
              style: AppTheme.textTheme.headlineSmall,
            ),
            Text("Locker: ABD 123", style: AppTheme.textTheme.headlineSmall),
            Text("Compartment: A 14", style: AppTheme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
