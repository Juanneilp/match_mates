import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/chat/detail_chat.dart';
import 'package:match_mates/provider/db_provider.dart';
import 'package:match_mates/provider/list_user_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/resources/enum.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _controler,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Provider.of<ListProfileProvider>(context, listen: false)
                          .getUser(_controler.text);
                    },
                  ),
                  label: const Text('Masukkan kata'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              //checking if the data from provider
              child: Consumer<ListProfileProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  } else if (state.state == ResultState.hasData) {
                    if (state.user.isEmpty) {
                      return const Center(
                        child: Text("No data was found"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: state.user.length,
                          itemBuilder: (context, index) {
                            return BuildTileUser(user: state.user[index]);
                          });
                    }
                  } else if (state.state == ResultState.error) {
                    return Center(child: Text(state.massage));
                  } else if (state.state == ResultState.noData) {
                    return const Center(child: Text("no data"));
                  } else {
                    return const Text("Something wrong");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }
}

class BuildTileUser extends StatelessWidget {
  final User user;
  const BuildTileUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ProfilePicture(linkImg: user.imagelinks, size: 25),
        title: Text(user.name),
        trailing: const Icon(Icons.arrow_right),
        onTap: () async {
          var tunelid = Provider.of<ProfileProvider>(context, listen: false)
              .connection(
                  user,
                  Provider.of<DatabaseProvider>(context, listen: false)
                      .user
                      .uid);
          // var tunelid = UserService().createConnection(user,
          //     Provider.of<DatabaseProvider>(context, listen: false).user.uid);
          //Provider.of<ProfileProvider>(context, listen: false).user.uid);
          var friends = Friend(
              nameid: user.uid,
              tunelid: await tunelid,
              imagelinks: user.imagelinks,
              name: user.name);
          Navigator.pushNamed(context, DetailsChat.routeNamed,
              arguments: friends);
        });
  }
}
