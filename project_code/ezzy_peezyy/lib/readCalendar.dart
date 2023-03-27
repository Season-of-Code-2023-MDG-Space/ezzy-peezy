// import 'package:googleapis/calendar/v3.dart' hide Colors;
// import 'package:googleapis/cloudsearch/v1.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'dart:developer';
// import 'wappCall.dart';
// import 'main.dart';


// class readCalendar
// {
//   wappcall wc = wappcall();
//    AuthClient? client ;

//   String getData(AuthClient cc ){ 
//     client = cc; 
//     print("just got data");
//     return "dsf";  }

//   void readEvents() async
//   {     DateTime startTime = DateTime.now();  
//         print("Entered in REad Events");
        
//         if(client == null){print("nalla client");}
        
//         DateTime endTime = DateTime.now().add(Duration(days: 2));
//         try{
//         var calendar = CalendarApi(client!);
//         String calendarId = "primary";
//         calendar.events.list(
//           calendarId,
//           q: "Event By Ezzy-Peezyy",
//           timeMax: endTime,
//           timeMin: startTime,
//         ).then((Events events) {
//           print("going correct till now");
//           if(events != null){
//         (events).items?.forEach((Event event) {
//           print(event.summary);
//           String des = event.description! ;
//           wc.launchWhatsAppUri(des);
//           }
//           );}
//         });

// }
// catch(e){print("error is $e");}
// }
// }