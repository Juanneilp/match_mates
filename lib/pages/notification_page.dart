import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static const routeNamed = '/notif_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('data'),
          )
        ],
      ),
    );
  }
}
