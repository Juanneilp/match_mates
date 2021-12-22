import 'package:flutter/material.dart';
import 'package:match_mates/pages/login/signin_page.dart';
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
              height: height * 0.2,
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
                        height: height * 0.15,
                        width: width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ProfilePicture(
                                  linkImg: snapshot.user.imagelinks, size: 60),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.user.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                    ),
                                    Text("Balance : ${snapshot.user.token}"),
                                    snapshot.user.talent
                                        ? const Chip(label: Text("Talent"))
                                        : const Chip(label: Text('User'))
                                  ],
                                ),
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
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () async {
                          await authService.signOut();
                          Navigator.pushReplacementNamed(
                              context, SignInPage.routeNamed);
                        },
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
                            // var user = Provider.of<ProfileProvider>(context,
                            //         listen: false)
                            //     .user;
                            Navigator.pushNamed(
                                context, SettingsEditPage.routeNamed,
                                arguments: snapshot.user);
                          },
                        )),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SettingsList(),
            ),
            Center(
              child: NameCard(
                text: snapshot.user.bio,
                heightScaling: 0.14,
                widthScaling: 0.6,
                textTitle: "Bio",
              ),
            ),
            Center(
              child: NameCard(
                text: snapshot.user.city,
                heightScaling: 0.08,
                widthScaling: 0.6,
                textTitle: "City",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameCard extends StatelessWidget {
  final String text;
  final double widthScaling;
  final double heightScaling;
  final String textTitle;
  const NameCard(
      {Key? key,
      required this.text,
      required this.widthScaling,
      required this.heightScaling,
      required this.textTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: SizedBox(
        width: width * widthScaling,
        height: height * heightScaling,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(textTitle,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                text,
                maxLines: 5,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
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
      builder: (_, PreferancesProvider snapshot, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Settings",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: SwitchListTile(
              value: snapshot.isDarktheme,
              onChanged: (value) {
                Provider.of<PreferancesProvider>(context, listen: false)
                    .enebleDarkTheme(value);
              },
              title: const Text("Dark Theme"),
            ),
          ),
        ],
      ),
    );
  }
}
