import 'package:whatsapp_unilink/whatsapp_unilink.dart';
// For Flutter applications, you'll most likely want to use
// the url_launcher package.
import 'package:url_launcher/url_launcher.dart';

class wappcall
{


launchWhatsAppUri(String des) async {
  int num = int.parse(des.substring(9, 18));  
  String text = des.substring(32);
  final link = WhatsAppUnilink(
    phoneNumber: '+91$num',
    text: text,

  );
  // Convert the WhatsAppUnilink instance to a Uri.
  // The "launch" method is part of "url_launcher".
  await launchUrl(link.asUri());
}
}