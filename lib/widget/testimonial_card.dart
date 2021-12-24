import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> testimonial =
        FirebaseFirestore.instance.collection('testimonial').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: testimonial,
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
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.size,
            itemBuilder: (context, index) {
              return ClipRRect(
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
                            Text('${data.docs[index]['name']}'),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text('${data.docs[index]['text']}'),
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
    );
  }
}
