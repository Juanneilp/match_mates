import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int totalNotification;

  NotificationBadge({required this.totalNotification});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration:
          BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '$totalNotification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
