import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/chat/detail_chat.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class ChatMenu extends StatelessWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, ProfileProvider snapshot, child) =>
          snapshot.user.friends.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.user.friends.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserTile(name: snapshot.user.friends[index]);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
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
            context: context, builder: (context) => ModalBottom()),
        onTap: () {
          Navigator.pushNamed(context, DetailsChat.routeNamed, arguments: name);
        });
  }
}

class ModalBottom extends StatelessWidget {
  const ModalBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: Text("halo"),
      ),
    );
  }
}
