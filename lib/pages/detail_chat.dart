import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/data_dummy.dart';
import 'package:match_mates/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class DetailsChat extends StatelessWidget {
  const DetailsChat({Key? key}) : super(key: key);
  static const routeNamed = "/details_chat";

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TextChat>(
      create: (_) => ChatStreamProvider(streamTunel: 'massage').getlistChat(),
      initialData: TextChat(reciver: '', sender: '', chat: []),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          flexibleSpace: HeaderChat(
            name: 'constantiantum',
            imageLink:
                'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg',
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
              const ChatInput()
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                imageLink,
                height: 40,
                width: 40,
              ),
            ),
            Padding(padding: const EdgeInsets.all(8), child: Text(name)),
          ],
        ),
      ),
    );
  }
}

class ChatText extends StatelessWidget {
  final Chat chat;
  final currentuser = "user";
  const ChatText({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chat.owner != currentuser) {
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
  const ChatInput({Key? key}) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          height: 40,
          width: double.infinity,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.add),
              focusColor: Colors.green.shade700,
              hoverColor: Colors.green.shade100,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _controller.clear;
                  ChatStreamProvider(streamTunel: 'massage').adduser(Chat(
                      content: _controller.text,
                      createdAt: Timestamp.now(),
                      owner: 'user'));
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
