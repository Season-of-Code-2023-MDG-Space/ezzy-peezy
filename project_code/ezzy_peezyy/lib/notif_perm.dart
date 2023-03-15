import 'package:flutter/material.dart';
import 'package:googleapis/androidenterprise/v1.dart';
import 'package:notification_reader/notification_reader.dart';
import 'package:permission_handler/permission_handler.dart' as p;
import 'notificsation_reader.dart';


class notif_perm extends StatefulWidget {
  const notif_perm({super.key});

  @override
  State<notif_perm> createState() => _notif_permState();
}
notif_reader nr = notif_reader();
class _notif_permState extends State<notif_perm> {
  
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
            body : ElevatedButton(
              onPressed: () async
              {await NotificationReader.openNotificationReaderSettings;
                // var status = await Permission.camera.status ;
                if (await  p.Permission.notification.request().isGranted) {
                    // nr.initPlatformState();
                    Navigator.pushNamed(context , '/home');
                  }
              }, 
              child: Center(child: Text("Permissions"))
              ),

    );
  }
}