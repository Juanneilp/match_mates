import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/text_chat.dart';
import 'package:match_mates/model/detail_chat_modal.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/provider/chat_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/resources/editpage.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class DetailsChat extends StatelessWidget {
  DetailsChat({Key? key, required this.arguments}) : super(key: key);
  static const routeNamed = "/details_chat";
  final DetailChatArguments arguments;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 2),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn));
    final Friend name = arguments.user;
    final int time = int.parse(arguments.price);
    return StreamProvider<TextChat>(
      create: (_) =>
          ChatStreamProvider(streamTunel: name.tunelid).getlistChat(),
      initialData: TextChat(reciver: '', sender: '', chat: []),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          flexibleSpace: Row(
            children: [
              HeaderChat(
                name: name.name,
                imageLink: name.imagelinks,
              ),
            ],
          ),
          actions: [
            Center(child: Clock(time: time)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.phone))
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Consumer<TextChat>(
                        builder: (context, TextChat snapshot, child) {
                          if (snapshot.chat.isNotEmpty) {
                            return ListView.builder(
                              controller: _scrollController,
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: ChatInput(
                  tunel: name.tunelid,
                ),
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
    if (chat.owner != currentuser.uid) {
      if (chat.type == "image") {
        return Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(
                  chat.content,
                  fit: BoxFit.cover,
                )),
          ),
        );
      } else {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: Theme.of(context).colorScheme.primary),
            child: Text(
              chat.content,
              // style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        );
      }
    } else {
      if (chat.type == "image") {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(
                  chat.content,
                  fit: BoxFit.cover,
                )),
          ),
        );
      } else {
        return Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: Theme.of(context).colorScheme.primary),
            child:
                Text(chat.content, style: const TextStyle(color: Colors.black)),
          ),
        );
      }
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
              prefixIcon: IconButton(
                  onPressed: () async {
                    File file = await selectFile();
                    String url = await uploadFile(file);
                    ChatStreamProvider(streamTunel: widget.tunel).adduser(Chat(
                        content: url,
                        createdAt: Timestamp.now(),
                        owner: owner.uid,
                        type: "image"));
                  },
                  icon: const Icon(Icons.add)),
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
                        owner: owner.uid,
                        type: "text"));
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
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  void countdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.time == 0 && mounted) {
        setState(() {
          timer.cancel();
          Navigator.of(context).pop();
        });
      } else {
        if (mounted) {
          setState(() {
            widget.time--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
