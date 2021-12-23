import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HangoutDetailPage extends StatelessWidget {
  final DocumentSnapshot document;

  HangoutDetailPage({required this.document});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> hangout =
        FirebaseFirestore.instance.collection('hangoutt').snapshots();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: hangout,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          document['url'],
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.black26,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            '${document['name']}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.green,
                              size: 20,
                            ),
                            Text(
                              '${document['street']}, ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '${document['city']}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Umur : ${document['age']},'),
                            SizedBox(
                              width: 10,
                            ),
                            document['gender']
                                ? Text('Laki-Laki')
                                : Text('Perempuan'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: 210,
                  // constraints: BoxConstraints(
                  //   maxHeight: double.infinity
                  // ),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Hangout',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.orangeAccent,
                              ),
                              Text('${document['rating']}'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                              '${document['text']}',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.album_sharp,
                                color: Colors.cyan,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${document['price']}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('/1 Jam')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Service Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 17,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Style : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('${document['style']}')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 17,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Feel to Free : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('${document['free']}')
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Available Time',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 17,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Hari : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Rabu - Jumat')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Order'),
          ),
        ),
      ),
    );
  }
}
