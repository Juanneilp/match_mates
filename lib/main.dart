import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/data_dummy.dart';
import 'package:match_mates/pages/detail_chat.dart';
import 'package:match_mates/pages/home_page.dart';
import 'package:match_mates/provider/chat_provider.dart';
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
        StreamProvider<List<TextChat>>(
            create: (_) => ChatStreamProvider().getlistChat(), initialData: [])
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: HomePage.routeNamed,
        routes: {
          HomePage.routeNamed: (context) => const HomePage(),
          DetailsChat.routeNamed: (context) => const DetailsChat(),
        },
      ),
    );
  }
}
