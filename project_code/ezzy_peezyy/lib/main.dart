// ignore_for_file: avoid_print
import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:googleapis/cloudsearch/v1.dart';
import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'whatsReply.dart';
import 'package:ezzy_peezy/speech_recognition_app/speech.dart';
import 'package:permission_handler/permission_handler.dart' as p;
import 'package:workmanager/workmanager.dart';
import 'package:ezzy_peezy/google_sign_in.dart';
import 'wappCall.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:intl/intl.dart';
import 'apicall.dart';
import "package:googleapis_auth/auth_io.dart";
// import 'readCalendar.dart';
import 'notificsation_reader.dart';
import 'notif_perm.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/home', routes: {
    '/notif': (context) => notif_perm(),
    '/home': (context) => Home(),
  }));
}

// readCalendar rc = readCalendar();
int n = 0;
int gg = 0;
google_sign_in g = google_sign_in();
notif_reader nr = notif_reader();
late AuthClient c;
AuthClient? a;
int k = 0;
String microphone = 'mic';
@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "call_whatsapp":
        print("Reading Evdtn from calendar");
        // read();
         readEvents();
        print("hellooo");
        // print("$e \n");
        // print("error here");

        //else{print("c is not null");}
        break;
      case 'call_notif':
        nr.initPlatformState();

        break;
      default:
        print(
            "NOthing to Dooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
        break;
    }
    return Future.value(true);
  });
}

AuthClient? client;
wappcall wc = wappcall();

//  AuthClient? client ;

// String getData(AuthClient cc ){
//   client = cc;
//   print("just got data");
//   return "dsf";  }


Future<void> readEvents() async {
  nr.initPlatformState();
  if (n == 0) {}
  DateTime startTime = DateTime.now();
  print("Entered in REad Events");

  // client = await(g.login());
  if (client == null) {
    print("nalla client");
    client= await (g.login());
  }

  DateTime endTime = DateTime.now().add(const Duration(days: 2));
  try {
    var calendar = CalendarApi(client!);
    String calendarId = "primary";
    print("got client and entered");
    calendar.events
        .list(
      calendarId,
      q: "Event By Ezzy-Peezyy",
      timeMax: endTime,
      timeMin: startTime,
    )
        .then((Events events) {
      print("going correct till now");
      if (events != null) {
        (events).items?.forEach((Event event) {
          print(event.summary);
          String des = event.description!;
          int num = int.parse(des.substring(9, 19));
          String text = des.substring(32);
          wc.launchWhatsAppUri(num, text);
        });
      }
    });
  } catch (e) {
    print("error is $e");
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  var items = [
    'Occasions',
    'Birthday',
    'Anniversary',
    'Congratulations',
    'Custom Message <3 '
  ];

  TextEditingController dateInput = TextEditingController();
  TextEditingController msgInput = TextEditingController();
  TextEditingController numinput = TextEditingController();
  List<Widget> textViewL = [];
  String send = "";
  String textHint = "";
  DateTime dt = DateTime(DateTime.now().year);
  bool isListening = false;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final String defaultLanguage = 'en-US';

  TextToSpeech tts = TextToSpeech();

  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language;
  String? languageCode;
  String? voice;


  void notifPermCheck() async {
    if (await p.Permission.notification.request().isDenied) {
      // nr.initPlatformState();
      Navigator.pushNamed(context, '/notif');
    }
  }
  Speech speech = Speech();
  String val = 'Occasions';
  whatsReply wR = whatsReply();

  @override
  void initState() {
    dateInput.text = "";
    notifStart();
    // permis();

    callGoogleLogin();
    notifPermCheck();
    _initSpeech();
    print("before Screen");
    nr.initPlatformState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      initLanguages();
    });
    super.initState();
    
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCode = defaultLanguage;
    language = await tts.getDisplayLanguageByCode(languageCode!);

   
    voice = await getVoiceByLang(languageCode!);
    }

    Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }
  void speak(String text) async {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(pitch);
    await tts.speak(text);
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
  
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);


    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() { 
      List<String > data = speech.talk(_lastWords);
       numinput.text = data[0];
      dateInput.text = data[1];
      _controller.text = data[2];
      msgInput.text = "";

      
    });
  }
  
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  apicall ap = apicall();

  void onLayoutDone(Duration timeStamp) async {
    await Permission.microphone.request();
    setState(() {});
  }

  void notifStart() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    if (Platform.isAndroid) {
      Workmanager().registerPeriodicTask(
        "calling notif reload",
        "call_notif",
        initialDelay: const Duration(seconds: 10),
        frequency: const Duration(minutes: 15),
      );
    }
  }

  void check() {
    // c=cc;
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    if (n != 0) {}

    if (Platform.isAndroid) {
      Workmanager().registerPeriodicTask(
        "simplePeriodicTask",
        "call_whatsapp",
        initialDelay: const Duration(seconds: 15),
        frequency: const Duration(minutes: 15),
      );
    } else {
      DateTime dt = DateTime.now();
      DateTime dt2 = DateTime(dt.year, dt.month, dt.day, 23, 59, 00);

      Workmanager().registerPeriodicTask(
        "simplePeriodicTask",
        "call_whatsapp",
        //initialDelay: Duration(seconds: 10),
        frequency: Duration(
          minutes: dt2.minute - dt.minute,
          hours: dt2.hour - dt.hour,
        ),
      );
    }
  }

  void callGoogleLogin() async {
    if (a == null) {
      print("Inside login page.");
      a = await (g.login());
    }
    // String s = await (rc.getData(a!));
    // rc.readEvents(a!);
    client = a;
    check();
  }

  // List<Contact>? contacts;
  // Future permis() async{
  //   var status = await Permission.contacts.status;

  //   if(status.isDenied || status.isRestricted){
  //     if (await Permission.speech.isPermanentlyDenied) { openAppSettings();}
  //   }
  //   else{ contacts = await ContactsService.getContacts(withThumbnails: false);
  //   print(contacts);}
  // }

  Widget _textView() {
    return (Container(
      margin: const EdgeInsets.only(left: 80, right: 80),
      child: TextField(
        controller: msgInput,
        decoration: InputDecoration(
          hintText: textHint,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Color.fromARGB(255, 136, 255, 0)),
            // borderRadius: BorderRadius.(Radius.circular(10.0)),
            borderRadius: BorderRadius.circular(26.0),
          ),
          fillColor: const Color.fromARGB(255, 226, 179, 37),
        ),
      ),
    ));
  }

  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('EEZY-PEEZY'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      // const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),

      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20.0,
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),

            // new PopupMenuButton<String>(
            //             icon: const Icon(Icons.contact_mail_sharp), // TO DO
            //             onSelected: (String value) {
            //                   numinput.text = value;
            //             },
            //             itemBuilder: (BuildContext context) {

            //               return items.map<PopupMenuItem<String>>((String value) {
            //                 return new PopupMenuItem(
            //                   child:  Text(value),value: value);
            //             }).toList();
            //             },
            //           ),

            child: TextField(
              controller: numinput,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Contact No.',
                icon: Icon(Icons.contact_mail_sharp),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(255, 136, 255, 0)),
                  // borderRadius: BorderRadius.(Radius.circular(10.0)),
                  borderRadius: BorderRadius.circular(26.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),

          Container(
            margin: const EdgeInsets.only(right: 15),
            child: TextField(
              textAlign: TextAlign.center,
              controller: dateInput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 136, 255, 0)),
                    // borderRadius: BorderRadius.(Radius.circular(10.0)),
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  hintText: "Date" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));
                DateTime d = pickedDate!;
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(d);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),

          // Container(
          // margin: const EdgeInsets.only(left: 40,right: 15),
          // child: TextField(controller: _controller,
          //   decoration:  InputDecoration(
          //     border: OutlineInputBorder(
          //       borderSide: const BorderSide(width: 3, color: Color.fromARGB(255, 136, 255, 0)),
          //       // borderRadius: BorderRadius.(Radius.circular(10.0)),
          //        borderRadius: BorderRadius.circular(26.0),
          //       ),
          //     hintText: 'Choose the Choice from Drop-Down List',
          //   ),
          //   readOnly: true,),
          // ),

          // PopupMenuButton<String>(
          //   icon: const Icon(Icons.arrow_drop_down),
          //   onSelected: (String value) {
          //   print(value);
          //     if(value == 'Birthday')
          //     {
          //         setState(() {

          //        if(textViewL.isNotEmpty){
          //         textViewL.clear();   }
          //       textHint = "Name of reciever";

          //       textViewL.add(_textView());

          //     });
          //         // call Birthday fn
          //         send ="Happy Birthday ";

          //     }
          //     else if(value =='Anniversary')
          //     {
          //       // call Aniver fn
          //        setState(() {if(textViewL.isNotEmpty){
          //         textViewL.clear();   }
          //       textHint = "Name of reciever";
          //       textViewL.add(_textView());

          //     });
          //         // call Birthday fn
          //         send ="Happy Anniversary ";

          //     }
          //     else if(value =='Congratulations')
          //     {
          //       // call Congratulations fn
          //        setState(() {
          //      if(textViewL.length ==1){
          //         textViewL.clear();   }
          //       textHint = "Name of reciever";

          //       textViewL.add(_textView());
          //       });
          //         // call Birthday fn
          //         send ="Congratulations ";

          //     }
          //     else if(value =='Custom Message <3')
          //     {
          //     setState(() {
          //      if(textViewL.length ==1){
          //         textViewL.clear();  }
          //        textHint ="Type Your Custom Message";

          //       textViewL.add(_textView());
          //       });}
          //     _controller.text = value;
          //   },
          //   itemBuilder: (BuildContext context) {
          //     return items.map<PopupMenuItem<String>>((String value) {
          //       return  PopupMenuItem(
          //         value: value,
          //         child:  Text(value));
          //   }).toList();
          //   },
          // ),
          DropdownButton(

              value: val,
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? value) {
                print(value);
                if (value == 'Birthday') {
                  setState(() {
                    val = 'Birthday';

                    if (textViewL.isNotEmpty) {
                      textViewL.clear();
                    }
                    textHint = "Name of reciever";

                    textViewL.add(_textView());
                  });
                  // call Birthday fn
                  send = "Happy Birthday ";
                } else if (value == 'Anniversary') {
                  // call Aniver fn
                  setState(() {
                    if (textViewL.isNotEmpty) {
                      val = 'Anniversary';

                      textViewL.clear();
                    }
                    textHint = "Name of reciever";
                    textViewL.add(_textView());
                  });
                  // call Birthday fn
                  send = "Happy Anniversary ";
                } else if (value == 'Congratulations') { Navigator.pushNamed(context , '/location');
                  val = 'Congratulations';
                  // call Congratulations fn
                  setState(() {
                    val = 'Congratulations';

                    if (textViewL.length == 1) {
                      textViewL.clear();
                    }
                    textHint = "Name of reciever";

                    textViewL.add(_textView());
                  });
                  // call Birthday fn
                  send = "Congratulations ";
                } else if (value == 'Custom Message <3') {
                  val = 'Custom Message <3';
                  setState(() {
                    val = 'Custom Message <3';

                    if (textViewL.length == 1) {
                      textViewL.clear();
                    }
                    textHint = "Type Your Custom Message";

                    textViewL.add(_textView());
                  });
                }
                _controller.text = value!;

                itemBuilder:
                (BuildContext context) {
                  return items.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(value: value, child: Text(value));
                  }).toList();
                };
              }),
          Container(
            height: 80.0,
            child: ListView.builder(
                itemCount: textViewL.length,
                itemBuilder: (context, index) {
                  return textViewL[index];
                }),
          ),

          ElevatedButton(
              onPressed: () async {
                nr.initPlatformState();
                //  print(wR.keywordChecker(msgInput.text));
                // use calander api here
                if (numinput.text != "" &&
                    dateInput.text != "" &&
                    _controller.text != "" &&
                    (numinput.text).length == 10 &&
                    val != 'Occasions') {
                  send = send + msgInput.text;
                  AuthClient clientt = a!;

                  send = "Number = ${numinput.text} : Message = $send";
                  await ap.apiCall(pickedDate!, clientt, send);

                  nr.initPlatformState();
                  numinput.text = "";
                  dateInput.text = "";
                  _controller.text = "";
                  msgInput.text = "";
                }
              },
              child: const Text('submit')), 
          const SizedBox(
            height: 40.0,
          ),
        ],
      ),

        floatingActionButton:FloatingActionButton(
        onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
         tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }

}
