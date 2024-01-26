import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uni_craft/Homepage.dart';
import 'package:uni_craft/auth-page.dart';
import 'package:uni_craft/dependency_injection.dart';
import 'package:uni_craft/notification.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/LoginPage.dart';
import 'splash.dart';
final navigatorKey = GlobalKey<NavigatorState>();

//function to lisen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
    navigatorKey.currentState!.pushNamed('/message',arguments: message);
  }
}
//NotificationServices notificationServices=NotificationServices();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //notificationServices.requestNotificationPermission();
  // //notificationServices.isTokenRefresh();
  // notificationServices.firebaseInit();
  // notificationServices.getDeviceToken().then((value){
  //   print('device token '+value);
  //
  //
  // });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });
  PushNotifications.init();
  PushNotifications.localNotiInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
  await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
 //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(Craft());
  DependencyInjection.init();
}
@pragma('vm:entry-point')
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();

}


class Craft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: "Uni Craft",
      debugShowCheckedModeBanner: true,
      home: Splash(),
    );
  }
}
