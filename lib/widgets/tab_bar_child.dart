import 'package:flutter/material.dart';

class TabBarChild extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color? iconColor;

  const TabBarChild({Key? key, required this.text, required this.iconData, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: iconColor ?? Colors.grey),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
