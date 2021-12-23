import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:match_mates/pages/echat/list_echat.dart';
import 'package:match_mates/pages/hangout/list_hangout.dart';
import 'package:match_mates/widget/testimonial_card.dart';

import 'notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Match Mates',
        ),
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
              height: 180,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          "https://picsum.photos/id/239/200/300",
                          width: 240,
                          fit: BoxFit.cover,
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          "https://picsum.photos/id/231/200/300",
                          width: 240,
                          fit: BoxFit.cover,
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          "https://picsum.photos/id/232/200/300",
                          width: 240,
                          fit: BoxFit.cover,
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          "https://picsum.photos/id/235/200/300",
                          width: 240,
                          fit: BoxFit.cover,
                        )),
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
            Container(
              height: 120,
              child: Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: GestureDetector(
                        child: Card(
                          child: Container(
                            color: Colors.blueGrey,
                            child: Center(
                              child: Text(
                                'E-Chat',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, EChatListPage.routeNamed);
                        },
                      )),
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      child: Card(
                        child: Container(
                          color: Colors.indigoAccent,
                          child: Center(
                            child: Text(
                              'Hangout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, HangoutListPage.routeNamed);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Row(
                children: [
                  Text(
                    'Temukan hal berdasarkan minat kamu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text('Coming Soon'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text('Coming Soon'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
            Row(
              children: [
                Container(height: 200, child: TestimonialCard()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
