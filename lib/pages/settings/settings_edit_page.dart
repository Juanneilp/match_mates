import 'dart:io';

import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/resources/editpage.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class SettingsEditPage extends StatefulWidget {
  static const routeNamed = "/edit_page";
  final UserProfile user;
  const SettingsEditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsEditPage> createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  final _controller = TextEditingController();
  final _bioController = TextEditingController();
  final _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              File file = await selectFile();
              String url = await uploadFile(file);
              Provider.of<ProfileProvider>(context, listen: false)
                  .setImgUser(url);
            },
            child: Consumer<ProfileProvider>(
              builder: (context, snapshot, child) => Center(
                  child: ProfilePicture(
                      linkImg: widget.user.imagelinks, size: 80)),
            ),
          ),
          EditCard(
            controller: _controller,
            text: "Fill your Name",
          ),
          EditCard(
            controller: _bioController,
            text: "Fill your Bio",
          ),
          EditCard(
            controller: _cityController,
            text: "Fill your City",
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setNameuser(_controller.text);
                    _controller.clear();
                  }
                  if (_bioController.text.isNotEmpty) {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setBiouser(_bioController.text);
                    _bioController.clear();
                  }
                  if (_cityController.text.isNotEmpty) {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setCityuser(_cityController.text);
                    _cityController.clear();
                  }
                  Navigator.of(context).pop();
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
    _bioController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}

class EditCard extends StatelessWidget {
  const EditCard({
    Key? key,
    required TextEditingController controller,
    required this.text,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text),
          Card(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
