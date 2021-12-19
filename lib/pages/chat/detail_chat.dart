import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/data_dummy.dart';
import 'package:match_mates/model/detail_chat_modal.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/provider/chat_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class DetailsChat extends StatelessWidget {
  const DetailsChat({Key? key, required this.arguments}) : super(key: key);
  static const routeNamed = "/details_chat";
  final DetailChatArguments arguments;

  @override
  Widget build(BuildContext context) {
    final Friend name = arguments.user;
    final int time = int.parse(arguments.price);
    return StreamProvider<TextChat>(
      create: (_) =>
          ChatStreamProvider(streamTunel: name.tunelid).getlistChat(),
      initialData: TextChat(reciver: '', sender: '', chat: []),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade100,
          flexibleSpace: Row(
            children: [
              HeaderChat(
                name: name.name,
                imageLink: name.imagelinks,
              ),
              Center(child: Clock(time: time)),
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Consumer<TextChat>(
                      builder: (context, TextChat snapshot, child) {
                        if (snapshot.chat.isNotEmpty) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.chat.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ChatText(chat: snapshot.chat[index]);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("no data yet"),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              ChatInput(
                tunel: name.tunelid,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderChat extends StatelessWidget {
  final String imageLink;
  final String name;
  const HeaderChat({Key? key, required this.imageLink, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ProfilePicture(linkImg: imageLink, size: 35),
            Padding(padding: const EdgeInsets.all(8), child: Text(name)),
          ],
        ),
      ),
    );
  }
}

class ChatText extends StatelessWidget {
  final Chat chat;
  const ChatText({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentuser = Provider.of<ProfileProvider>(context).user;
    if (chat.owner != currentuser.name) {
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(colors: [Colors.pink, Colors.purple])),
          child: Text(
            chat.content,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(colors: [Colors.purple, Colors.pink])),
          child:
              Text(chat.content, style: const TextStyle(color: Colors.black)),
        ),
      );
    }
  }
}

class ChatInput extends StatefulWidget {
  final String tunel;
  const ChatInput({Key? key, required this.tunel}) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final owner = Provider.of<ProfileProvider>(context).user;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(40)),
          height: 40,
          width: double.infinity,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.add),
              hintText: "your massgae",
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_controller.text == "") {
                  } else {
                    ChatStreamProvider(streamTunel: widget.tunel).adduser(Chat(
                        content: _controller.text,
                        createdAt: Timestamp.now(),
                        owner: owner.name));
                    _controller.clear();
                  }
                },
              ),
            ),
          )),
    );
  }

//avoiding memory leak
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Clock extends StatefulWidget {
  int time;
  Clock({Key? key, required this.time}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    countdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.time.toString(),
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  void countdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.time == 0) {
        setState(() {
          timer.cancel();
          Navigator.of(context).pop();
        });
      } else {
        setState(() {
          widget.time--;
        });
      }
    });
  }
}
