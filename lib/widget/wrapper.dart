import 'package:flutter/material.dart';
import 'package:match_mates/model/login.dart';
import 'package:match_mates/pages/bottom_nav.dart';
import 'package:match_mates/pages/login/signin_page.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const routeNamed = '/';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return StreamBuilder<Login?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<Login?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final Login? login = snapshot.data;
          return login == null && snapshot.data?.email == true ? SignInPage() : BottomNavigation();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
