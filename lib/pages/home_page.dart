import 'package:flutter/material.dart';
import 'package:match_mates/pages/chat_menu_pages.dart';
import 'package:match_mates/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeNamed = "/home_pages";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final tabScreen = const [
    Center(
      child: Text("Not Yet"),
    ),
    ChatMenu(),
    Center(
      child: Text("Not Yet"),
    ),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabScreen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Notification"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "User Settings"),
          ]),
    );
  }
}
