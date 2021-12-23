import 'package:flutter/material.dart';
import 'package:match_mates/model/detail_chat_modal.dart';
import 'package:match_mates/model/talent_model.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/chat/detail_chat.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/resources/transaction.dart';
import 'package:provider/provider.dart';

class ModalBottom extends StatefulWidget {
  final TalentModel sellers;
  final User user;
  final int price;

  const ModalBottom(
      {Key? key,
      required this.sellers,
      required this.user,
      required this.price})
      : super(key: key);

  @override
  State<ModalBottom> createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("choose price",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        Wrap(
          spacing: 10.00,
          children: [
            chipBuild('30', context),
            chipBuild('60', context),
            chipBuild('90', context),
            chipBuild('120', context),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () async {
                var total = widget.sellers.price * (int.parse(selected) / 30);
                print(selected != "");
                print(widget.user.token);
                if (selected != "" && widget.user.token > total.toInt()) {
                  TransactionBase().createTransaction(
                      widget.sellers.uid, widget.user.uid, total.toInt());
                  var tunelid =
                      Provider.of<ProfileProvider>(context, listen: false)
                          .talentModelConnection(widget.sellers, widget.user);
                  var friends = Friend(
                      nameid: widget.sellers.uid,
                      tunelid: await tunelid,
                      imagelinks: widget.sellers.url,
                      name: widget.sellers.name);
                  Navigator.of(context).pushNamed(DetailsChat.routeNamed,
                      arguments:
                          DetailChatArguments(user: friends, price: selected));
                }
              },
              child: const Text('Confirm')),
        ])
      ],
    );
  }

  Widget chipBuild(String text, BuildContext context) {
    final bool option = selected == text;
    final color = option
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    return InkWell(
      onTap: () {
        setState(() {
          selected = text;
        });
      },
      child: Chip(
        avatar: const Icon(
          Icons.album_sharp,
          color: Colors.cyan,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
