import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EChatListPage extends StatelessWidget {
  static const routeNamed = '/echat_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Chat'),
      ),
      body: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Text('Sort By')
                ],
              ),
            ),
            Expanded(child: ListEChat())],
        ),
      ),
    );
  }
}

class ListEChat extends StatelessWidget {
  const ListEChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> echat =
    FirebaseFirestore.instance.collection('e_chat').snapshots();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: StreamBuilder<QuerySnapshot>(
          stream: echat,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong.');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            final data = snapshot.requireData;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Card(
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 80,
                              width: 65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  '${data.docs[index]['url']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 235,
                              padding: EdgeInsets.only(left: 8, top: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${data.docs[index]['name']}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('${data.docs[index]['style']}', style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text('${data.docs[index]['regards']}'),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.album_sharp,
                                        color: Colors.cyan,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '${data.docs[index]['price']}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    '${data.docs[index]['rating']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
