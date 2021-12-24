import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/login/signin_page.dart';
import 'package:match_mates/pages/settings/about_page.dart';
import 'package:match_mates/pages/settings/reedem_pages.dart';
import 'package:match_mates/pages/settings/settings_edit_page.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/provider/shared_preferances.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final authService = Provider.of<AuthServices>(context, listen: false);

    return SafeArea(
      child: Consumer<ProfileProvider>(
          builder: (context, snapshot, child) => ListView(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.25,
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: BackgroundCustomClipper(),
                          child: Container(
                            width: width,
                            height: height * 0.2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Card(
                            child: SizedBox(
                              height: height * 0.17,
                              width: width * 0.6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ProfilePicture(
                                            linkImg: snapshot.user.imagelinks,
                                            size: 60),
                                        Text(
                                          snapshot.user.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            Icons.album_sharp,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              snapshot.user.token.toString()),
                                        ),
                                        snapshot.user.talent
                                            ? Chip(
                                                label: Text("Talent"),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                        .withOpacity(0.6),
                                              )
                                            : Chip(
                                                label: Text('User'),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                        .withOpacity(0.6),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: const Icon(Icons.settings),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SettingsEditPage.routeNamed,
                                      arguments: snapshot.user);
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("User Detail Profile",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: NameCard(
                      user: snapshot.user,
                      heightScaling: 0.3,
                      widthScaling: 0.9,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text("Others Option",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: Icon(Icons.redeem),
                    title: Text('Redeem Token'),
                    onTap: () {
                      Navigator.of(context).pushNamed(RedeemPage.routeNamed,
                          arguments: snapshot.user);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About App'),
                    onTap: () {
                      Navigator.of(context).pushNamed(AboutPage.routeNamed);
                    },
                  ),
                  SettingsList(),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Log Out"),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("Warning"),
                              content: Text("Are you sure to exit?"),
                              actions: [
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                    child: Text("Yes"),
                                    onPressed: () async {
                                      await authService.signOut();
                                      Navigator.pushReplacementNamed(
                                          context, SignInPage.routeNamed);
                                    })
                              ]);
                        },
                      );
                    },
                  ),
                ],
              )),
    );
  }
}

class NameCard extends StatelessWidget {
  final UserProfile user;
  final double widthScaling;
  final double heightScaling;
  const NameCard({
    Key? key,
    required this.user,
    required this.widthScaling,
    required this.heightScaling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var sexIcon =
        user.gender.toLowerCase() == "male" ? Icons.male : Icons.female;
    return Card(
      child: SizedBox(
        width: width * widthScaling,
        height: height * heightScaling,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TileText(
                  icon: Icons.all_inbox_rounded, content: user.bio, number: 5),
              TileText(
                  icon: Icons.location_on_outlined,
                  content: user.city,
                  number: 1),
              TileText(icon: sexIcon, content: user.gender, number: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class TileText extends StatelessWidget {
  final IconData icon;
  final String content;
  final int number;
  const TileText(
      {Key? key,
      required this.icon,
      required this.content,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(icon),
        ),
        Text(
          content,
          overflow: TextOverflow.fade,
          maxLines: number,
        )
      ],
    );
  }
}

class BackgroundCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint1 = Offset(50, size.height - 100);
    var controlPoint2 = Offset(size.width, size.height);
    var endPoint = Offset(size.width, size.height - 50);

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, PreferancesProvider snapshot, child) => ListTile(
        leading:
            snapshot.isDarktheme ? Icon(Icons.dark_mode) : Icon(Icons.light),
        onTap: () {
          var value = snapshot.isDarktheme;
          value = !value;
          Provider.of<PreferancesProvider>(context, listen: false)
              .enebleDarkTheme(value);
        },
        title: const Text("Dark Theme"),
      ),
    );
  }
}
