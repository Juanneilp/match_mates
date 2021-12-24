import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/hangout_model.dart';
import 'package:match_mates/pages/hangout/detail_hangout.dart';
import 'package:match_mates/provider/hangout_provider.dart';
import 'package:match_mates/resources/enum.dart';
import 'package:provider/provider.dart';

class HangoutListPage extends StatefulWidget {
  const HangoutListPage({Key? key}) : super(key: key);
  static const routeNamed = '/hangout_list';

  @override
  State<HangoutListPage> createState() => _HangoutListPageState();
}

class _HangoutListPageState extends State<HangoutListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HangoutNotifyProvider>(
      create: (_) => HangoutNotifyProvider(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('Hangout'),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white30,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<HangoutNotifyProvider>().getUserByRating();
                    },
                    child: const Text('Sort By Rating'),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<HangoutNotifyProvider>().getUserByPrice();
                    },
                    child: const Text('Sort By Price'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<HangoutNotifyProvider>(
                  builder: (context, HangoutNotifyProvider snapshot, _) {
                if (snapshot.state == ResultState.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                } else if (snapshot.state == ResultState.hasData) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.model.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListHangout(
                          model: snapshot.model[index],
                        );
                      },
                    ),
                  );
                } else if (snapshot.state == ResultState.error) {
                  return Center(child: Text(snapshot.massage));
                } else if (snapshot.state == ResultState.noData) {
                  return Center(child: Text(snapshot.massage));
                } else {
                  return const Text("something wrong?...");
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ListHangout extends StatelessWidget {
  final HangoutModel model;
  ListHangout({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(HangoutDetailPage.routeNamed, arguments: model);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    height: 80,
                    width: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        model.url,
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
                              model.name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.style,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(model.regards),
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
                              model.price.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
                          color: Colors.orangeAccent,
                        ),
                        Text(
                          model.rating.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
