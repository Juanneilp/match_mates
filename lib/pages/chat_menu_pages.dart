import 'package:flutter/material.dart';
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
                    return UserTile(
                        imagelink: snapshot.user[index].imagelinks,
                        name: snapshot.user[index].name);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}

class UserTile extends StatelessWidget {
  final String imagelink;
  final String name;
  const UserTile({
    Key? key,
    required this.imagelink,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(imagelink),
        ),
        title: Text(name),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.pushNamed(context, DetailsChat.routeNamed);
        });
  }
}
