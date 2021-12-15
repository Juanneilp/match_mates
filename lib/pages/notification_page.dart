import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/push_notification.dart';
import 'package:match_mates/widget/notification_badge.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationPage extends StatefulWidget {
  static const routeNamed = '/notif_page';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

  PushNotification? _notificationInfo;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Mendapatkan Izin');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });

        if (notification != null) {
          showSimpleNotification(Text(_notificationInfo!.title!),
              leading: NotificationBadge(
                  totalNotification: _totalNotificationCounter),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan,
              duration: Duration(seconds: 2));
        }
      });
    } else {
      print('Izin tidak diberikan');
    }
  }

  checkInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    });

    registerNotification();
    checkInitialMessage();
    _totalNotificationCounter = 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Notification unread : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  NotificationBadge(
                      totalNotification: _totalNotificationCounter),
                ],
              ),
            ),
            _notificationInfo != null
                ? Container(
              height: 90,
                  child: Column(
                      children: [
                        Expanded(
                          child: Card(
                            child: ListTile(
                              onTap: () {},
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    'https://picsum.photos/id/239/200/300'),
                              ),
                              title: Text(
                                  'Title ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}'),
                              subtitle: Text(
                                  'Subtitle ${_notificationInfo!.dataBody ?? _notificationInfo!.body}'),
                            ),
                          ),
                        )
                      ],
                    ),
                )
                : Container(
                    // child: Expanded(
                    //     child: Card(
                    //       child: ListTile(
                    //         onTap: () {},
                    //         leading: ClipRRect(
                    //           borderRadius: BorderRadius.circular(20),
                    //           child: Image.network(
                    //               'https://picsum.photos/id/239/200/300'),
                    //         ),
                    //         title: Text('Title'),
                    //         subtitle: Text('isi'),
                    //       ),
                    //     ),
                    //   ),
                    ),
          ],
        ),
      ),
    );
  }
}
