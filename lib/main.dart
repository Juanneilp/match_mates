import 'package:flutter/material.dart';
import 'package:match_mates/pages/detail_chat.dart';
import 'package:match_mates/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeNamed,
      routes: {
        HomePage.routeNamed: (context) => const HomePage(),
        DetailsChat.routeNamed: (context) => const DetailsChat(),
      },
    );
  }
}
