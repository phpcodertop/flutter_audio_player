import 'package:flutter/material.dart';

import '../app_colors.dart';

class SingleTab extends StatelessWidget {
  final String text;
  final Color color;

  const SingleTab({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
