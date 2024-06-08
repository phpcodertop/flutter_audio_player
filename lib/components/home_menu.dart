import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageIcon(
            AssetImage('img/menu.png'),
            size: 24,
            color: Colors.black,
          ),
          Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.notifications),
            ],
          ),
        ],
      ),
    );
  }
}
