import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/category_dummy.dart';
import 'package:match_mates/pages/login/signin_page.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:match_mates/widget/category_chip.dart';
import 'package:match_mates/widget/circle_avatar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: BannerProfile()),
        Flexible(child: CategoryBox()),
        Flexible(child: SettingsList()),
        Center(
          child: SizedBox(
            height: 35,
            width: 100,
            child: Material(
              color: Colors.lightBlueAccent,
              child: ElevatedButton(
                onPressed: () async {
                  await authService.signOut();
                  Navigator.pushReplacementNamed(context, SignInPage.routeNamed);
                },
                child: Text(
                  "Log Out",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Settings",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: SwitchListTile(
            value: false,
            onChanged: (value) {},
            title: const Text("contoh setting"),
          ),
        ),
      ],
    );
  }
}

class CategoryBox extends StatelessWidget {
  const CategoryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("CATEGORY",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Wrap(
          children: categoryList
              .map((e) => CategoryChip(category: e.name, color: e.color))
              .toList()
              .cast<Widget>(),
        ),
      ],
    );
  }
}

class BannerProfile extends StatelessWidget {
  const BannerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, snapshot, child) => SafeArea(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              gradient:
                  LinearGradient(colors: [Colors.deepPurple, Colors.white])),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfilePicture(
                  linkImg: snapshot.user.imagelinks.isNotEmpty
                      ? snapshot.user.imagelinks
                      : "",
                  size: 80,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot.user.name.isNotEmpty
                      ? Text(
                          "Name :${snapshot.user.name}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "Name :",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
