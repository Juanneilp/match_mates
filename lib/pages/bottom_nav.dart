import 'package:flutter/material.dart';
import 'package:match_mates/pages/chat/chat_menu_pages.dart';
import 'package:match_mates/pages/home_page.dart';
import 'package:match_mates/pages/search_page.dart';
import 'package:match_mates/pages/settings/settings_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routeNamed = "/bottom_nav";

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 3;
  final tabScreen = [
    const HomePage(),
    SearchPage(),
    const ChatMenu(),
    const SettingsPage(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "User Settings"),
          ]),
    );
  }
}
