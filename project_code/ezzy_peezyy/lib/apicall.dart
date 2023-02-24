
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'dart:io' show Platform ;
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'Credentials/cred.dart';
import 'dart:developer';

String respo="";

class apicall  {

 
  static const _scopes =  [CalendarApi.calendarScope];
  // ignore: prefer_typing_uninitialized_variables
  var _credentials;
  
  void apiCall(DateTime dt) {
    cred c =  cred();
    print("inside apiCall");
    if (Platform.isAndroid) {
      _credentials =  ClientId(
          c.ClientId_android,
          "");
    } else if (Platform.isIOS) {
      _credentials =  ClientId(
          c.ClientId_ios,
          "");
    }
  

  Event event = Event(); // Create object of event
  
  DateTime dtStart =  DateTime(dt.year,dt.month , dt.day , 0,0,0);
  DateTime dtEnd =  DateTime(dt.year,dt.month , dt.day , 23,59,59);
  
  
  
  EventDateTime start =  EventDateTime(); //Setting start time
      start.dateTime = dtStart;
      start.timeZone = "GMT+05:00";
      event.start = start;

      
      EventDateTime end =  EventDateTime(); //setting end time
      end.timeZone = "GMT+05:00";
      end.dateTime = dtEnd;
      event.end = end;


}
insertEvent(event){
try {
        clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client){
        var calendar = CalendarApi(client);
        String calendarId = "primary";
        calendar.events.insert(event,calendarId).then((value) {
        
          if (value.status == "confirmed") {print ("pp");
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
        });
      } catch (e) {
        log('Error creating event $e');
      }
}

  void prompt(String url) async {

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }}