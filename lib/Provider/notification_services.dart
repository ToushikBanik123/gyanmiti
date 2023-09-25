import 'dart:io';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../SplashScreen.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User denied Permission");
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    if(Platform.isAndroid){
      initLocalNotification(context, message);
      showNotifications(message);
    }
      print(message.notification!.title);
      print(message.notification!.body);
      // showNotifications(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notification',
      importance: Importance.max,
    );
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      print("Refresh");
    });
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('logo'); // Use the resource name without the file extension

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        if(Platform.isAndroid){
          handleMessage(context, message);
        }
      },
    );
  }

  Future<void> setupInteractMessage(BuildContext context)async {

    //When App is Terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }

    //When App is in Background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }
  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data['type'] == 'msg'){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    }
  }
}
