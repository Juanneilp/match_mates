import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class SettingsEditPage extends StatefulWidget {
  static const routeNamed = "/edit_page";
  final User user;
  const SettingsEditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsEditPage> createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Center(
              child: ProfilePicture(linkImg: widget.user.imagelinks, size: 80)),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Fill your name"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                onPressed: () {
                  Provider.of<ProfileProvider>(context, listen: false)
                      .setNameuser(_controller.text);
                  _controller.clear();
                },
                child: const Text("simpan")),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
