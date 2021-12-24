import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/detail_chat_modal.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/chat/detail_chat.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class ChatMenu extends StatelessWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat History"),
      ),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider snapshot, child) {
        if (snapshot.user.sellers.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.user.sellers.length,
            itemBuilder: (BuildContext context, int index) {
              return UserTile(
                name: snapshot.user.sellers[index],
                user: snapshot.user,
              );
            },
          );
        } else if (snapshot.user.sellers.isEmpty) {
          return const Center(
            child: Text("no data"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class UserTile extends StatelessWidget {
  final Sellers name;
  final UserProfile user;

  const UserTile({
    Key? key,
    required this.name,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfilePicture(linkImg: name.imagelinks, size: 50),
      title: Text(name.name),
      trailing: const Icon(Icons.arrow_right),
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) => ModalBottom(
                user: user,
                sellers: name,
                price: name.price,
              )),
    );
  }
}

class ModalBottom extends StatefulWidget {
  final Sellers sellers;
  final UserProfile user;
  final int price;
  const ModalBottom(
      {Key? key,
      required this.user,
      required this.sellers,
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
                if (selected != "" && widget.user.token > total.toInt()) {
                  await Provider.of<ProfileProvider>(context, listen: false)
                      .createTransaction(widget.sellers.nameid, widget.user.uid,
                          total.toInt());
                  var tunelid =
                      Provider.of<ProfileProvider>(context, listen: false)
                          .sellersConnection(widget.sellers, widget.user);
                  var friends = Friend(
                      nameid: widget.sellers.nameid,
                      tunelid: await tunelid,
                      imagelinks: widget.sellers.imagelinks,
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
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
