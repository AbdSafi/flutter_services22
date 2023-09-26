import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationFCM extends StatefulWidget {
  const NotificationFCM({super.key});

  @override
  State<NotificationFCM> createState() => _NotificationFCMState();
}
    ////
class _NotificationFCMState extends State<NotificationFCM> {
  String? token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print('---------------------------------------');
    print(token);
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('fcm ----------------------------');
      if (message.notification != null) {
        print('${message.notification!.title}');
        print('${message.notification!.body}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Notify: ${message.notification!.body}")));
    });
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await sendMessage(token, "hi abd safi", "welcome to saudi");
          },
          child: const Text("Send Notification"),
        ),
      ),
    );
  }
}

sendMessage(token, title, message) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAA_Da9Ffg:APA91bGHW_AdVQSck7HBDlCLIbqgKUPSFfjdXDVXwc5sEX7odbBRzCl5s3KgOIAV0Z5PS3W19gTiQ00pucREwd7pmPCB9JENieyOztlBE4lY8hGZ7kmCqNj6_MwandUYRulTw9UScq1d'
  };
  var request =
      http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
  request.body = json.encode({
    "to": token,
    "notification": {"title": title, "body": message}
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
