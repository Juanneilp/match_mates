import 'package:flutter/material.dart';
import 'package:match_mates/model/talent_model.dart';
import 'package:match_mates/provider/e_chat_notify_provider.dart';
import 'package:match_mates/resources/enum.dart';
import 'package:provider/provider.dart';
import 'package:match_mates/pages/echat/detail_echat.dart';

class EChatListPage extends StatefulWidget {
  static const routeNamed = '/echat_list';

  @override
  State<EChatListPage> createState() => _EChatListPageState();
}

class _EChatListPageState extends State<EChatListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EChatNotifyProvider>(
      create: (_) => EChatNotifyProvider(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('E-Chat'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<EChatNotifyProvider>().getUserByRating();
                    },
                    child: const Text('Sort By Rating'),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<EChatNotifyProvider>().getUserByPrice();
                    },
                    child: const Text('Sort By Price'),
                  )
                ],
              ),
            ),
            const Expanded(child: ListEChat())
          ],
        ),
      ),
    );
  }
}

class ListEChat extends StatelessWidget {
  const ListEChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<EChatNotifyProvider>(
        builder: (context, EChatNotifyProvider snapshot, child) {
          if (snapshot.state == ResultState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else if (snapshot.state == ResultState.hasData) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.model.length,
                itemBuilder: (BuildContext context, int index) {
                  return TilesTalent(
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
        },
      ),
    );
  }
}

class TilesTalent extends StatelessWidget {
  TalentModel model;
  TilesTalent({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EChatDetailPage.routeNamed,
            arguments: model);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            child: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                          model.style.toString(),
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
