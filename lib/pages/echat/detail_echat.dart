import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/talent_model.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/widget/modal_bottom.dart';
import 'package:provider/provider.dart';

class EChatDetailPage extends StatelessWidget {
  static const routeNamed = '/detail_echat';
  final TalentModel document;

  EChatDetailPage({required this.document});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, ProfileProvider snapshot, child) => Scaffold(
        body: SingleChildScrollView(
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
                        document.url,
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
                          document.name,
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
                            document.city,
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
                          Text('Umur : ${document.age.toString()},'),
                          SizedBox(
                            width: 10,
                          ),
                          document.gender
                              ? Text('Laki-Laki')
                              : Text('Perempuan'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  margin:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'E-Chat',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                            Text(document.rating.toString()),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Text(document.text),
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
                              document.price.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('/30 Menit')
                          ],
                        )
                      ],
                    ),
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
                      Padding(
                        padding: EdgeInsets.only(
                          left: 17,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Style : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(document.style)
                          ],
                        ),
                      ),
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
                          children: const [
                            Text(
                              'Hari : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Senin - Rabu')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => ModalBottom(
                          sellers: document,
                          user: snapshot.user,
                          price: document.price,
                        ));
              },
              child: const Text('Order'),
            ),
          ),
        ),
      ),
    );
  }
}
