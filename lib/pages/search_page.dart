import 'package:flutter/material.dart';
import 'package:match_mates/model/detail_chat_modal.dart';
import 'package:match_mates/model/talent.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/chat/detail_chat.dart';
import 'package:match_mates/provider/list_user_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/resources/enum.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _controler,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Provider.of<ListProfileProvider>(context, listen: false)
                          .getUser(_controler.text);
                    },
                  ),
                  label: const Text('Masukkan kata'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (context, result, _) => Expanded(
                flex: 2,
                //checking if the data from provider
                child: Consumer<ListProfileProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    } else if (state.state == ResultState.hasData) {
                      if (state.user.isEmpty) {
                        return const Center(
                          child: Text("No data was found"),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: state.user.length,
                            itemBuilder: (context, index) {
                              return BuildTileUser(
                                user: state.user[index],
                                userprofile: result.user,
                              );
                            });
                      }
                    } else if (state.state == ResultState.error) {
                      return Center(child: Text(state.massage));
                    } else if (state.state == ResultState.noData) {
                      return const Center(child: Text("no data"));
                    } else {
                      return const Text("Something wrong");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }
}

class BuildTileUser extends StatelessWidget {
  final Talent user;
  final UserProfile userprofile;
  const BuildTileUser({Key? key, required this.user, required this.userprofile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfilePicture(linkImg: user.url, size: 25),
      title: Text(user.name),
      trailing: const Icon(Icons.arrow_right),
      onTap: () async {
        showModalBottomSheet(
            context: context,
            builder: (context) => ModalBottom(
                  sellers: user,
                  user: userprofile,
                  price: user.price,
                ));
      },
    );
  }
}

class ModalBottom extends StatefulWidget {
  final Talent sellers;
  final UserProfile user;
  final int price;

  const ModalBottom(
      {Key? key,
      required this.sellers,
      required this.user,
      required this.price})
      : super(key: key);

  @override
  State<ModalBottom> createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("choose price",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        Wrap(
          spacing: 10.00,
          children: [
            chipBuild('30', context),
            chipBuild('60', context),
            chipBuild('90', context),
            chipBuild('120', context),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () async {
                var total = widget.sellers.price * (int.parse(selected) / 30);
                print(selected != "");
                print(widget.user.token);
                if (selected != "" && widget.user.token > total.toInt()) {
                  await Provider.of<ProfileProvider>(context, listen: false)
                      .createTransaction(
                          widget.sellers.uid, widget.user.uid, total.toInt());
                  var tunelid =
                      Provider.of<ProfileProvider>(context, listen: false)
                          .talentConnection(widget.sellers, widget.user);
                  var friends = Friend(
                      nameid: widget.sellers.uid,
                      tunelid: await tunelid,
                      imagelinks: widget.sellers.url,
                      name: widget.sellers.name);
                  Navigator.of(context).pushNamed(DetailsChat.routeNamed,
                      arguments:
                          DetailChatArguments(user: friends, price: selected));
                }
              },
              child: const Text('Confirm')),
        ])
      ],
    );
  }

  Widget chipBuild(String text, BuildContext context) {
    final bool option = selected == text;
    final color = option
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    return InkWell(
      onTap: () {
        setState(() {
          selected = text;
        });
      },
      child: Chip(
        avatar: const Icon(
          Icons.album_sharp,
          color: Colors.cyan,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
