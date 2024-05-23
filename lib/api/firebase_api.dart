import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();


  void initNotification(BuildContext context){
    requestNotificationPermission();
    firebaseInit(context);
    getDeviceToken().then((value){
      print("Device Token: ${value}");
    });
  }

  void requestNotificationPermission() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );
  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print("User granted Permission");
  }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
    print("User granted Permission");
  }else{
    print("User denied Permission");
  }
  }
  void initLocalNotifications(BuildContext context , RemoteMessage message) async{
    var androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialzationSettings = DarwinInitializationSettings();

    var initialzationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitialzationSettings
    );

    await _flutterLocalNotificationPlugin.initialize(
      initialzationSetting,
      onDidReceiveNotificationResponse: (payload){

      }
    );

  }
  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message){
      if (Platform.isAndroid) {
        initLocalNotifications( context,message);
        showNotification(message);
      }
    });
  }
  Future<String> getDeviceToken() async{
    String? token = await messaging.getToken();
    return token!;
  }
  void isTokenRefresh() async{
    messaging.onTokenRefresh.listen((event){
      event.toString();
      print("refresh");
    });
  }
  Future<void> showNotification(RemoteMessage message) async {


    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        Random.secure().nextInt(1000).toString(),
        'High Importance Notification',
        channelDescription: 'Your channel description',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker'
    );
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );


    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationPlugin.show(
          message.notification.hashCode,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails
      );
    }
    );



  }

}
