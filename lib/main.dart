import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/detail_chat_modal.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/pages/bottom_nav.dart';
import 'package:match_mates/pages/echat/list_echat.dart';
import 'package:match_mates/pages/hangout/list_hangout.dart';
import 'package:match_mates/pages/chat/detail_chat.dart';
import 'package:match_mates/pages/login/signin_page.dart';
import 'package:match_mates/pages/login/signup_page.dart';
import 'package:match_mates/pages/notification_page.dart';
import 'package:match_mates/pages/settings/settings_edit_page.dart';
import 'package:match_mates/provider/list_user_provider.dart';
import 'package:match_mates/provider/profile_provider.dart';
import 'package:match_mates/provider/shared_preferances.dart';
import 'package:match_mates/resources/theme.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:match_mates/service/preferences_helper.dart';
import 'package:match_mates/service/user_service.dart';
import 'package:match_mates/widget/wrapper.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
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
          ChangeNotifierProvider<PreferancesProvider>(
            create: (_) => PreferancesProvider(
              prefencesHelper: PrefencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => ProfileProvider(
                  username: UserService().getUser()?.uid ?? "")),
          ChangeNotifierProvider<ListProfileProvider>(
            create: (_) => ListProfileProvider(),
          ),
        ],
        builder: (context, child) => OverlaySupport(
              child: MaterialApp(
                themeMode: Provider.of<PreferancesProvider>(context).isDarktheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: CustomTheme.lightTheme,
                darkTheme: CustomTheme.darkTheme,
                initialRoute: Wrapper.routeNamed,
                routes: {
                  Wrapper.routeNamed: (context) => Wrapper(),
                  SignInPage.routeNamed: (context) => SignInPage(),
                  SignUpPage.routeNamed: (context) => SignUpPage(),
                  BottomNavigation.routeNamed: (context) =>
                      const BottomNavigation(),
                  DetailsChat.routeNamed: (context) => DetailsChat(
                      arguments: ModalRoute.of(context)?.settings.arguments
                          as DetailChatArguments),
                  NotificationPage.routeNamed: (context) => NotificationPage(),
                  SettingsEditPage.routeNamed: (context) => SettingsEditPage(
                      user: ModalRoute.of(context)?.settings.arguments as User),
                  EChatListPage.routeNamed: (context) => EChatListPage(),
                  HangoutListPage.routeNamed: (context) =>
                      const HangoutListPage()
                },
              ),
            ));
  }
}
