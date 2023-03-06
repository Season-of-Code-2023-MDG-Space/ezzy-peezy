// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> init() async{
//     final AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid, 
//     );

//       await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//     }
//     static final NotificationService _notificationService =
//       NotificationService._internal();


//   factory NotificationService() {
//     return _notificationService;
//   }

// Future selectNotification(String payload) async {
//       //Handle notification tapped logic here
//    }

//   Future onSelectNotification() async {
//       //Handle notification tapped logic here
//    } 
//   NotificationService._internal();
  
// }