import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Mates'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationPage.routeNamed);
            },
            icon: Icon(
              CupertinoIcons.bell,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                            "https://picsum.photos/id/239/200/300")),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                            "https://picsum.photos/id/231/200/300")),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                            "https://picsum.photos/id/232/200/300")),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                            "https://picsum.photos/id/235/200/300")),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Text(
                    'Layanan apa yang kamu cari?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.eleven_mp),
                      iconSize: 70,
                    ),
                    Text('E-Chat')
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.eleven_mp),
                      iconSize: 70,
                    ),
                    Text('Games')
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.eleven_mp),
                      iconSize: 70,
                    ),
                    Text('yeah')
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.eleven_mp),
                      iconSize: 70,
                    ),
                    Text('yeah')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Text(
                    'Temukan hal berdasarkan minat kamu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    height: 80,
                    width: 150,
                    child: ListView(
                      children: [
                        Card(
                          child: Text('Gaming'),
                        ),
                        Card(
                          child: Text('Musik'),
                        ),
                      ],
                    )
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 16),
              child: Row(
                children: [
                  Text(
                    'Testimonial',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 250,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.green,
                                  size: 35,
                                ),
                                const SizedBox(width: 5),
                                Text('Yaya'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
