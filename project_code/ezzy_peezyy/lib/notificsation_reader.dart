
import 'package:notification_reader/notification_reader.dart';
import 'dart:async';

class notif_reader
{
   Future<void> initPlatformState() async {
    try{
    print("inside notif_reader");
    NotificationData res = await NotificationReader.onNotificationRecieve();
    if (res.body != null) 
    { print("inside resource body");
      Timer.periodic( Duration(seconds: 1) , (timer) async {
        var res = await NotificationReader.onNotificationRecieve();
          // final body = json.decode(res.data);
            // print(body);
          print(res.data);
          print("Res.body = ${res}");
          print("Res.title = ${res.title }");
          print("reached here");
      
      });}
      
    }catch(e){print("no notification error");
    }
  }
}