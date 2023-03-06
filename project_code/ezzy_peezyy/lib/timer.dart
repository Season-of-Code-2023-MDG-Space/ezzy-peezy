// import 'dart:io';
// import 'package:googleapis_auth/auth_io.dart';

// import 'readCalendar.dart';
// import 'main.dart';
// import 'package:workmanager/workmanager.dart';

// class timer
// { readCalendar rc = readCalendar();
//   int n=0;
// late AuthClient c;
//   @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
      
//       case "call_whatsapp":
//         print("Reading Evdtn from calendar");
//         rc.readEvents(c);
//         break;
     
//     }
// return Future.value(true);
// });
// }

// void check(AuthClient cc)
// { 
//   c=cc;  
//    Workmanager().initialize(
//                       callbackDispatcher,
//                       isInDebugMode: true,
//                     );
//     if(n!=0){                

//    if(Platform.isAndroid)
//    {
//     Workmanager().registerPeriodicTask(
//                               "simplePeriodicTask",
//                               "call_whatsapp",
//                               //initialDelay: Duration(seconds: 10),
//                               frequency: Duration(minutes: 15),
//                             );
//    }}
//   else
//   {

//   }
// }

// }