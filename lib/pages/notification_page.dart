import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static const routeNamed = '/notif_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {},
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network('https://picsum.photos/id/239/200/300'),
                ),
                title: Text('Judul'),
                subtitle: Text('isinya ditulis disini'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
