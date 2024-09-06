import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../bottombar.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message =
        ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    if (message == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
        ),
        body: Center(
          child: Text("No message received"),
        ),
        bottomNavigationBar: BottomBar(
          navigateTo: (routeName) {
            Navigator.pushReplacementNamed(context, routeName);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title: ${message.notification?.title ?? 'No Title'}"),
          Text("Body: ${message.notification?.body ?? 'No Body'}"),
          Text("Data: ${message.data}"),
        ],
      ),
      bottomNavigationBar: BottomBar(
        navigateTo: (routeName) {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    );
  }
}
