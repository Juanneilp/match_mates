import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/bottom_nav.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class RedeemPage extends StatelessWidget {
  static const routeNamed = "/redeem_page";
  final UserProfile user;
  RedeemPage({Key? key, required this.user}) : super(key: key);
  final TextEditingController _reedem_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Menu"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Center(child: Text("Input Token")),
              Card(
                child: TextField(
                  controller: _reedem_controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text("Insert token"),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_reedem_controller.text.isNotEmpty) {
                      var text = await Provider.of<ProfileProvider>(context,
                              listen: false)
                          .getPoints(_reedem_controller.text, user.uid);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(""),
                              content: Text("Redeem $text"),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => BottomNavigation(),
                                    ));
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: Text("Redeem"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
