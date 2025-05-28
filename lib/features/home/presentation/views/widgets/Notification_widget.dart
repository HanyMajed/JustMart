import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const ShapeDecoration(shape: OvalBorder(), color: Color.fromRGBO(31, 61, 120, 0.2) // 50% transparent
          ),
      child: Icon(
        Icons.notifications_none,
        color: Colors.grey.shade700,
      ),
    );
  }
}
