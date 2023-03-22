import 'package:whatsapp_unilink/whatsapp_unilink.dart';
// For Flutter applications, you'll most likely want to use
// the url_launcher package.
import 'package:url_launcher/url_launcher.dart';

class wappcall
{


launchWhatsAppUri(int num , String text) async {
  
  // final link = WhatsAppUnilink(
  //   phoneNumber: '+91$num',
  //   text: text,

  // );
  // Convert the WhatsAppUnilink instance to a Uri.
  // The "launch" method is part of "url_launcher".
   String url = "whatsapp://send?phone=91$num&text=${Uri.encodeComponent(text)}";
  await canLaunchUrl(Uri.parse(url)) != null  ? launchUrl(Uri.parse(url)) : print("cant open whatsapp");
}
}