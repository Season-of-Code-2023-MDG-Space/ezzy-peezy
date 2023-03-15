
// ignore_for_file: avoid_print
import 'dart:io';
import 'package:workmanager/workmanager.dart';
import 'package:ezzy_peezy/google_sign_in.dart';
import 'package:ezzy_peezy/timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'apicall.dart';
import "package:googleapis_auth/auth_io.dart";
import 'readCalendar.dart';
import 'notificsation_reader.dart';
import 'notif_perm.dart';
void main() {
  runApp(MaterialApp(
      initialRoute: '/notif',
    routes: {
     '/notif' :(context) => notif_perm(),
      '/home': (context) => Home(),
    }
  ));
}

readCalendar rc = readCalendar();
  int n=0;

late AuthClient c;
  AuthClient? a;

  @pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      
      case "call_whatsapp":
        print("Reading Evdtn from calendar");
        rc.readEvents();
        print("checked");
        break;
      default:
      print("NOthing to Dooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      break;  
     
      

    }
return Future.value(true);
});
}


class Home extends StatefulWidget {
  const Home({super.key});

 

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  var items = ['Birthday', 'Anniversary', 'Congratulations','Custom Message <3'];
 
  TextEditingController dateInput = TextEditingController();
  TextEditingController msgInput = TextEditingController();
  TextEditingController numinput  = TextEditingController();
  List<Widget> textViewL = [];
  String send="";
  String textHint="";
  DateTime dt =  DateTime(DateTime.now().year);
  google_sign_in g = google_sign_in();

  

  @override
  void initState() {
    dateInput.text = "";
    
    // permis();
    callGoogleLogin();
    
     print("before Screen");
     nr.initPlatformState();
    super.initState();
  }
  apicall ap =  apicall();




void check(AuthClient cc)
{ 
  c=cc;  
   Workmanager().initialize(
                      callbackDispatcher,
                      isInDebugMode: true,
                    );
    // if(n==0)
    {               

   if(Platform.isAndroid)
   {
    print("Calling the fn");
    Workmanager().registerPeriodicTask(
                              "simplePeriodicTask",
                              "call_whatsapp",
                              // inputData: <String, dynamic>{'client' :c},
                              // initialDelay: Duration(seconds: 10),
                              frequency: const Duration(minutes: 15),
                            );
   }}
  // else if(n==0)
  // {

  //   DateTime dt = DateTime.now();
  //   DateTime dt2 = DateTime(dt.year , dt.month , dt.day , 23 , 59 , 00);
  //   n++;

  //  Workmanager().registerPeriodicTask(
  //                             "simplePeriodicTask",
  //                             "call_whatsapp",
  //                             //initialDelay: Duration(seconds: 10),
  //                             frequency: Duration(
  //                             minutes: dt2.minute - dt.minute,
  //                             hours: dt2.hour - dt.hour,
  //                             ),
  //                           );
  // }

  }


void callGoogleLogin() async{
    if(a == null){
      print("Inside login page.");
    a = await(g.login());
    }
    String s = await (rc.getData(a!));
    // rc.readEvents(a!); 
    check(a!);

  
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
  
  Widget _textView(){
    return(
      Container(
        
      margin: const EdgeInsets.only(left: 80,right: 80),
      
          child: TextField(
              controller: msgInput,
              
              decoration: InputDecoration(
          hintText: textHint,
          border: const OutlineInputBorder(),
        
                
                fillColor: const Color.fromARGB(255, 226, 179, 37),
              
            ),),
)
);}
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('EEZY-PEEZY'),
          centerTitle: true,
          backgroundColor: Colors.red[800],
        ),
    // const Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
           
        body: Column(

          children:<Widget> [
            const SizedBox(height: 20.0,),
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
            keyboardType: TextInputType.number,
        
        
            decoration: const InputDecoration(
              icon: Icon(Icons.contact_mail_sharp),
              border: OutlineInputBorder(),
              hintText: 'Enter the Contact No.',
            ),
           ),
           ),
           const SizedBox(height: 8.0,),
           
           Container(
            
          margin: const EdgeInsets.only(right: 15),
           child:TextField(
          
              controller: dateInput,
              //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  border: OutlineInputBorder(),
                  labelText: "Enter Date" //label text of field
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
                DateTime d = pickedDate! ;  
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(d);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),),
          const SizedBox(height: 8.0 ,),

          Container(
          margin: const EdgeInsets.only(left: 40,right: 15),
          child: TextField(controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Choose the Choice from Drop-Down List',
            ),
            readOnly: true,),),
                      
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                        print(value);
                          if(value == 'Birthday')
                          {   
                              setState(() {
                                
                             if(textViewL.isNotEmpty){
                              textViewL.clear();   }
                            textHint = "Name of reciever"; 
                            
                            textViewL.add(_textView()); 
                            
                                         
                          });
                              // call Birthday fn
                              send ="Happy Birthday ";
                              
                          }
                          else if(value =='Anniversary') 
                          {
                            // call Aniver fn
                             setState(() {if(textViewL.isNotEmpty){
                              textViewL.clear();   }
                            textHint = "Name of reciever"; 
                            textViewL.add(_textView()); 
                            
                                      
                          });
                              // call Birthday fn
                              send ="Happy Anniversary ";
                             
                          }
                          else if(value =='Congratulations') 
                          {
                            // call Congratulations fn
                             setState(() {
                           if(textViewL.length ==1){
                              textViewL.clear();   }
                            textHint = "Name of reciever"; 
                            
                            textViewL.add(_textView()); 
                            });
                              // call Birthday fn
                              send ="Congratulations ";
                             
                          }
                          else if(value =='Custom Message <3') 
                          {
                          setState(() {
                           if(textViewL.length ==1){
                              textViewL.clear();  } 
                             textHint ="Type Your Custom Message";              
                            
                            textViewL.add(_textView()); 
                            });}
                          _controller.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return items.map<PopupMenuItem<String>>((String value) {
                            return  PopupMenuItem(
                              value: value,
                              child:  Text(value));
                        }).toList();
                        },
                      ),
                      
                      Container(
                        height: 80.0,
                        
                        
                       child: ListView.builder
                       (
                        itemCount: textViewL.length,
                          itemBuilder: (context,index){
                        return textViewL[index];
                      }),
                      ),

                      ElevatedButton(onPressed: (){
                        // use calander api here
                        if(numinput.text != "" &&  dateInput.text!= "" &&_controller.text!= "" && (numinput.text).length ==10) {
                       send = send + msgInput.text;
                       AuthClient clientt = a!;
                       send = "Number = ${numinput.text} : Message = $send";
                        ap. apiCall(pickedDate!,clientt , send);
                        numinput.text ="";
                        dateInput.text="";
                        _controller.text="";
                        msgInput.text ="";
                        

                      }},
                      
                       child: const Text(
                        'submit'
                       ))

            
          
          ],   ),   
        );

    
  }
  
  
}