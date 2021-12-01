import 'package:flutter/material.dart';
import 'package:match_mates/model/data_dummy.dart';

class DetailsChat extends StatelessWidget {
  const DetailsChat({Key? key}) : super(key: key);
  static const routeNamed = "/details_chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        flexibleSpace: const HeaderChat(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: chatlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatText(textChat: chatlist[index]);
                    },
                  ),
                ),
              ],
            ),
            const ChatInput()
          ],
        ),
      ),
    );
  }
}

class HeaderChat extends StatelessWidget {
  const HeaderChat({Key? key}) : super(key: key);

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
                "https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg",
                height: 40,
                width: 40,
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(8), child: Text("KONSTANTIATUM")),
          ],
        ),
      ),
    );
  }
}

class ChatText extends StatelessWidget {
  final TextChat textChat;
  const ChatText({Key? key, required this.textChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textChat.user) {
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(colors: [Colors.pink, Colors.purple])),
          child: Text(
            textChat.chatString,
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
          child: Text(textChat.chatString,
              style: const TextStyle(color: Colors.black)),
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
              suffixIcon: const Icon(Icons.send),
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
