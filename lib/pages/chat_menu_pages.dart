import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/detail_chat.dart';
import 'package:match_mates/provider/list_user_provider.dart';
import 'package:provider/provider.dart';

class ChatMenu extends StatelessWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProfileProvider>(
      builder: (context, ListProfileProvider snapshot, child) =>
          snapshot.user.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.user.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserTile(name: snapshot.user[index]);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}

class UserTile extends StatelessWidget {
  final User name;
  const UserTile({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(name.imagelinks),
        ),
        title: Text(name.name),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.pushNamed(context, DetailsChat.routeNamed, arguments: name);
        });
  }
}
