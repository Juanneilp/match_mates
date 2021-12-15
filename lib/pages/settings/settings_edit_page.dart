import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/widget/circle_avatar.dart';

class SettingsEditPage extends StatelessWidget {
  static const routeNamed = "/edit_page";
  final User user;
  const SettingsEditPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Center(child: ProfilePicture(linkImg: user.imagelinks, size: 80)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Fill your name"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
