import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/bottom_nav.dart';
import 'package:match_mates/pages/detail_chat.dart';
import 'package:match_mates/pages/login/signin_page.dart';
import 'package:match_mates/pages/login/signup_page.dart';
import 'package:match_mates/pages/notification_page.dart';
import 'package:match_mates/provider/list_user_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:match_mates/widget/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get initialData => null;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(create: (_) => AuthServices()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(username: 'username')),
        ChangeNotifierProvider<ListProfileProvider>(
            create: (_) => ListProfileProvider(username: 'username'))
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: Wrapper.routeNamed,
        routes: {
          Wrapper.routeNamed: (context) => Wrapper(),
          SignInPage.routeNamed: (context) => SignInPage(),
          SignUpPage.routeNamed: (context) => SignUpPage(),
          BottomNavigation.routeNamed: (context) => const BottomNavigation(),
          DetailsChat.routeNamed: (context) => DetailsChat(
              name: ModalRoute.of(context)?.settings.arguments as User),
          NotificationPage.routeNamed: (context) => NotificationPage(),
        },
      ),
    );
  }
}
