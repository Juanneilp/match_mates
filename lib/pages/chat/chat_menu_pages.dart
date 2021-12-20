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
        if (snapshot.user.friends.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.user.friends.length,
            itemBuilder: (BuildContext context, int index) {
              return UserTile(name: snapshot.user.friends[index]);
            },
          );
        } else if (snapshot.user.friends.isEmpty) {
          return Center(
            child: Text("no data"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class UserTile extends StatelessWidget {
  final Friend name;
  const UserTile({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ProfilePicture(linkImg: name.imagelinks, size: 50),
        title: Text(name.name),
        trailing: const Icon(Icons.arrow_right),
        onLongPress: () => showModalBottomSheet(
            context: context,
            builder: (context) => ModalBottom(
                  user: name,
                )),
        onTap: () {
          Navigator.pushNamed(context, DetailsChat.routeNamed, arguments: name);
        });
  }
}

class ModalBottom extends StatefulWidget {
  final Friend user;
  const ModalBottom({Key? key, required this.user}) : super(key: key);

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
        Text("choose price",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        Wrap(
          spacing: 10.00,
          children: [
            chipBuild('10', context),
            chipBuild('30', context),
            chipBuild('45', context),
            chipBuild('60', context),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                selected != ""
                    ? Navigator.of(context).pushNamed(DetailsChat.routeNamed,
                        arguments: DetailChatArguments(
                            user: widget.user, price: selected))
                    : () {};
              },
              child: Text('Confirm')),
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
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
