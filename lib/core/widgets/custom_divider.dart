import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 260,
      child: Row(
        spacing: 10,
        children: [
          Expanded(child: Divider()),
          Text('or'),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
