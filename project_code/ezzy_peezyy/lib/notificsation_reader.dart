
import 'package:notification_reader/notification_reader.dart';
import 'dart:async';
import 'whatsReply.dart';
class notif_reader
{   
   Future<void> initPlatformState() async {
    try{
    whatsReply wR = whatsReply();
    print("inside notif_reader");
    NotificationData res = await NotificationReader.onNotificationRecieve();
    print(res.packageName);
    
    res.body ??= " ";  
    if (res.body != null) 
    { print("inside resource body");
      Timer.periodic( Duration(seconds: 1) , (timer) async {
        print("kk");
        try{
        NotificationData res = await NotificationReader.onNotificationRecieve();
          // final body = json.decode(res.data);
          //   print(body);
          // print(res.data);
          // print("Res.body = ${res}");
          // print("Res.title = ${res.title }");
          // print("reached here");
          print(res.packageName);
            if(res.packageName == 'com.whatsapp' && res.data['android.textLines'] != null){
              // print("inside com.whatsapp package");
              wR.keywordChecker( res.data['android.textLines'] ,  res.data['android.title']);

              print(res.data['android.textLines']);
              // print(res.data);
              // print("${res.body}");
            }

        }catch(e){print("issue in reading data  $e");}
      }
      );
      
      }
      
    }catch(e){print("no notification error");
    }
  }
}