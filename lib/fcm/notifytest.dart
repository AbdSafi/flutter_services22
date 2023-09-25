import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationFCM extends StatefulWidget {
  const NotificationFCM({super.key});

  @override
  State<NotificationFCM> createState() => _NotificationFCMState();
}

class _NotificationFCMState extends State<NotificationFCM> {
  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('---------------------------------------');
    print(token);
  }


  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Container(),
    );
  }
}
