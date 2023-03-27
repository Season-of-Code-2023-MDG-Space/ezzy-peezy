
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';


class google_sign_in
{

final GoogleSignIn _googleSignIn = GoogleSignIn(
     scopes: <String>[
       CalendarApi.calendarEventsScope
    ],
    // clientId: ClientId_android
);
  AuthClient? client;

  Future<bool> isSignedIn()
  {
      return(_googleSignIn.isSignedIn());
  
  }
  Future<AuthClient?> login() async {
    //print("heh");
    //  await _googleSignIn.disconnect();
   
   await _googleSignIn.signIn();
  client = await _googleSignIn.authenticatedClient();
   return client;

  
      
  
  }

    

}