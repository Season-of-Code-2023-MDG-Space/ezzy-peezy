
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' hide Colors;

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
  TextEditingController _controller = new TextEditingController();
  var items = ['Birthday', 'Anniversary', 'Congratulations','Custom Message <3'];
 
  TextEditingController dateInput = TextEditingController();
  TextEditingController msgInput = TextEditingController();
  TextEditingController numinput = TextEditingController();
  List<Widget> textViewL = [];


  void initState(){
    dateInput.text = "";
    super.initState();

  }

  Widget _textView(){
    return(
      Container(
        
      margin: EdgeInsets.only(left: 80,right: 80),
      
          child: TextField(
              controller: msgInput,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type Custom Message',
                fillColor: Color.fromARGB(255, 226, 179, 37),
              ),
            ),
)
);}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('EEZY-PEEZY'),
          centerTitle: true,
          backgroundColor: Colors.red[800],
        ),
    // const Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
           
        body: Column(

          children:<Widget> [
            SizedBox(height: 20.0,),
        TextField( controller: numinput,
        keyboardType: TextInputType.number,
        
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter the Contact No.',
            ),
           ),
           SizedBox(height: 8.0,),
           TextField(
          
              controller: dateInput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  border: OutlineInputBorder(),
                  labelText: "Enter Date" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));
 
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
          SizedBox(height: 8.0 ,),

          TextField(controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Choose the Choice from Drop-Down List',
            ),
            readOnly: true,),
                      
                      new PopupMenuButton<String>(
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
                            return new PopupMenuItem(
                              child:  Text(value),value: value);

                              
                          
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
                      
                      },
                    
                       child: Text(
                        'submit'
                       ))

            
          
          ],   ),   
        );

    
  }
}