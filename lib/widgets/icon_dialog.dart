import 'package:firebase_sample/utilities/colors.dart';
import 'package:flutter/material.dart';

class IconDialog extends StatelessWidget {
  const IconDialog({
    required this.content,
    required this.icon,
    this.iconColor = Colors.white,
    this.iconBackground = Colors.green,
    Key? key,
  }) : super(key: key);

  final Widget content;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackground;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: snowGrand,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: content,
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: iconBackground,
              child: Icon(
                icon,
                size: 25,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
