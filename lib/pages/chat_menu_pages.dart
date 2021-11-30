import 'package:flutter/material.dart';
import 'package:match_mates/pages/detail_chat.dart';

class ChatMenu extends StatelessWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                  "https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg"),
            ),
            title: const Text("random person"),
            onTap: () {
              Navigator.pushNamed(context, DetailsChat.routeNamed);
            })
      ],
    );
  }
}
