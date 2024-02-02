import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'notifications_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    // notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notifications'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              // send notification from one device to another
              notificationServices.getDeviceToken().then((value) async {
                var data = {
                  'to':
                      'cBF7o1HMT7yerQoejYIVEq:APA91bEZelrRFcrrmE5v0dcOiAuONEwY__mILhqUOaOh1rJODH4IvIy5vlcU3X31AuvO7zytfeK67tqbWNJAKneIKWFv09-nd5s8X3YYiQmordPszJZ9l60bLBEWYbPEawFiMB4G1zVs',
                  'notification': {
                    'title': 'Notificatio🔔',
                    'body': 'It is working fine',
                    "sound": "jetsons_doorbell.mp3"
                  },
                  // 'android': {
                  //   'notification': {
                  //     'notification_count': 23,
                  //   },
                  // },
                  'data': {'type': 'msg', 'id': 'Suraj99'}
                };

                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAAJaZwtHM:APA91bEAKJPY2h8TMdDtoTwT9IIk_6tHHWdAjrLdIiFs4O_Lat-H3f_mA2Js7Avi8mDvbau6DfeUgdURMv7-l0Ves2qbqYlGvIrAo6A-3DeqV28FbrBaHvTpGaRc1PtqXHElEM4GTGZ-'
                    });
              });
              //.then((value) {
              //     if (kDebugMode) {
              //       print(value.body.toString());
              //     }
              //   }).onError((error, stackTrace) {
              //     if (kDebugMode) {
              //       print(error);
              //     }
              //   });
              // });
            },
            child: const Text('Send Notifications')),
      ),
    );
  }
}
