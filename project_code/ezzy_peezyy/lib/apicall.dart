
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

 
  static const _scopes = const [CalendarApi.calendarScope];
  var _credentials;
  
  Future api_call(DateTime dt) async{
    cred c = new cred();
   
    if (Platform.isAndroid) {
      _credentials = new ClientId(
          c.ClientId_android,
          "");
    } else if (Platform.isIOS) {
      _credentials = new ClientId(
          c.ClientId_ios,
          "");
    }
  

  Event event = Event(); // Create object of event
  
  DateTime dt_start = new DateTime(dt.year,dt.month , dt.day , 0,0,0);
  DateTime dt_end = new DateTime(dt.year,dt.month , dt.day , 23,59,59);
  
  
  
  EventDateTime start = new EventDateTime(); //Setting start time
      start.dateTime = dt_start;
      start.timeZone = "GMT+05:00";
      event.start = start;

      
      EventDateTime end = new EventDateTime(); //setting end time
      end.timeZone = "GMT+05:00";
      end.dateTime = dt_end;
      event.end = end;


}
insertEvent(event){
try {
        clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client){
        var calendar = CalendarApi(client);
        String calendarId = "primary";
        calendar.events.insert(event,calendarId).then((value) {
        
          if (value.status == "confirmed") {
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

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }}