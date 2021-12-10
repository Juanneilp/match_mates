import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/bottom_nav.dart';
import 'package:match_mates/pages/detail_chat.dart';
import 'package:match_mates/pages/login/login_page.dart';
import 'package:match_mates/pages/login/register_page.dart';
import 'package:match_mates/pages/notification_page.dart';
import 'package:match_mates/provider/list_user_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(username: 'username')),
        ChangeNotifierProvider<ListProfileProvider>(
            create: (_) => ListProfileProvider(username: 'username'))
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: LoginPage.routeNamed,
        routes: {
          LoginPage.routeNamed: (context) => LoginPage(),
          RegisterPage.routeNamed: (context) => RegisterPage(),
          BottomNavigation.routeNamed: (context) => const BottomNavigation(),
          DetailsChat.routeNamed: (context) => DetailsChat(
              name: ModalRoute.of(context)?.settings.arguments as User),
          NotificationPage.routeNamed: (context) => NotificationPage(),
        },
      ),
    );
  }
}
