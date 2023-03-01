
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'Credentials/cred.dart';


String respo="";

class apicall  {

 final GoogleSignIn _googleSignIn = GoogleSignIn(
     scopes: <String>[
       CalendarApi.calendarEventsScope
    ],
    // clientId: ClientId_android
);

  static const _scopes =  [CalendarApi.calendarScope];
  // ignore: prefer_typing_uninitialized_variables
  var _credentials;
  
  void apiCall(DateTime dt) async {
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
       await login();
      final AuthClient? client = await _googleSignIn.authenticatedClient();

      {AuthClient clientt = client! ;
          insertEvent(event , clientt);}

}
insertEvent(event ,client) async{
try {
       

        var calendar = CalendarApi(client);
        String calendarId = "primary";
        calendar.events.insert(event,calendarId).then((value) {
        
          if (value.status == "confirmed") {print ("pp");
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
        
      } catch (e) {
        log('Error creating event $e');
      }
}


  
  Future<void> login() async {
    //print("heh");
    //  await _googleSignIn.disconnect();
    await _googleSignIn.signIn();
      
  }
  }