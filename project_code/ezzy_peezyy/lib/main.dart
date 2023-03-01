
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'apicall.dart';

void main() {
  runApp(MaterialApp(
    home : Home()
  ));
}

class Home extends StatefulWidget {
 

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  var items = ['Birthday', 'Anniversary', 'Congratulations','Custom Message <3'];
 
  TextEditingController dateInput = TextEditingController();
  TextEditingController msgInput = TextEditingController();
  TextEditingController numinput  = TextEditingController();
  List<Widget> textViewL = [];

  DateTime dt =  DateTime(DateTime.now().year);

  @override
  void initState(){
    dateInput.text = "";
    // permis();
    super.initState();

  }
  apicall ap =  apicall();
                        
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type Custom Message',
                fillColor: Color.fromARGB(255, 226, 179, 37),
              ),
            ),
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
        
            child: TextField( controller: numinput,
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
                        print("$value");
                          if(value == 'Birthday')
                          {
                              // call Birthday fn
                              
                          }
                          else if(value =='Anniversary') 
                          {
                            // call Aniver fn
                          }
                          else if(value =='Congratulations') 
                          {
                            // call Congratulations fn
                          }
                          else if(value =='Custom Message <3') 
                          {
                          setState(() {
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
                        if(numinput.text != "" &&  dateInput.text!= "" &&_controller.text!= "") {
                        ap. apiCall(pickedDate!);
                        numinput.text ="";
                        dateInput.text="";
                        _controller.text="";
                      }},
                    
                       child: const Text(
                        'submit'
                       ))

            
          
          ],   ),   
        );

    
  }
  
  
}