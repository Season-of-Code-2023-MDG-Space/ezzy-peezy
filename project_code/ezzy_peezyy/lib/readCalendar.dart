import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:developer';
import 'wappCall.dart';

class readCalendar
{
  wappcall wc = wappcall();
  void readEvents(AuthClient client) async
  {     DateTime startTime = DateTime.now();  

  DateTime endTime = DateTime.now().add(Duration(days: 2));
        var calendar = CalendarApi(client);
        String calendarId = "primary";
        calendar.events.list(
          calendarId,
          q: "Event By Ezzy-Peezyy",
          timeMax: endTime,
          timeMin: startTime,
        ).then((Events events) {
          if(events != null){
        (events).items?.forEach((Event event) {
          print(event.summary);
          String des = event.description! ;
          wc.launchWhatsAppUri(des);
          }
          );}
        });
}
}