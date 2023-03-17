
import 'package:notification_reader/notification_reader.dart';
import 'dart:async';

class notif_reader
{
   Future<void> initPlatformState() async {
    try{
    
    print("inside notif_reader");
    NotificationData res = await NotificationReader.onNotificationRecieve();
    print(res.packageName);
    
    res.body ??= " ";  
    if (res.body != null) 
    { print("inside resource body");
      Timer.periodic( Duration(seconds: 1) , (timer) async {
        print("kk");
        var res = await NotificationReader.onNotificationRecieve();
          // final body = json.decode(res.data);
            // print(body);
          print(res.data);
          print("Res.body = ${res}");
          print("Res.title = ${res.title }");
          print("reached here");
          print({res.packageName});
      }
      );
      
      }
      
    }catch(e){print("no notification error");
    }
  }
}