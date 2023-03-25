import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Speech {
  List<String> talk(String input)
  {   List<String> data = [];
    Fluttertoast.showToast(
        msg: input,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    String date ='01';
    String number = '';
    if(input.contains('number'))
    {
      int index = input.indexOf('number');
      number = input.substring(index+10 , index+14)+input.substring(index+15 , index+18)+input.substring(index+19 , index+22);
       if (int.tryParse(number) != null) {
          int num = int.parse(number);
       }
    }data.add(number);
    if(input.contains('date'))
        {
          int indexDate = input.indexOf('date');
          indexDate +=8;
          String month = '05';
          if(input.contains('january'))
             month = '01';
          else if(input.contains('February'))
             month = '02';
          else if(input.contains('March'))
             month = '03';
          else if(input.contains('April'))
             month = '04';
          else if(input.contains('may'))
             month = '05';
          else if(input.contains('june'))
             month = '06';
          else if(input.contains('july'))
             month = '07';
          else if(input.contains('august'))
             month = '08';
          else if(input.contains('september'))
             month = '09';
          else if(input.contains('october'))
             month = '10';
          else if(input.contains('november'))
             month = '10';
          else if(input.contains('December'))
             month = '12'; 
             
           if(input.contains('01'))
              date ='01';
            else if(input.contains('02'))
              date ='02';
            else if(input.contains('03'))
              date ='03';
            else if(input.contains('04'))
              date ='04';
            else if(input.contains('05'))
              date ='05';
            else if(input.contains('06'))
              date ='06';
            else if(input.contains('07'))
              date ='07';
            else if(input.contains('08'))
              date ='08';
            else if(input.contains('09'))
              date ='09';
            else if(input.contains('10'))
              date ='10';
            else if(input.contains('11'))
              date ='11';
            else if(input.contains('12'))
              date ='12';
            else if(input.contains('13'))
              date ='13';
            else if(input.contains('14'))
              date ='14';
            else if(input.contains('15'))
              date ='15';
            else if(input.contains('16'))
              date ='16';
            else if(input.contains('17'))
              date ='17';
            else if(input.contains('18'))
              date ='18';
            else if(input.contains('19'))
              date ='19';
            else if(input.contains('20'))
              date ='20';
            else if(input.contains('21'))
              date ='21';
            else if(input.contains('22'))
              date ='22';
            else if(input.contains('23'))
              date ='23';
            else if(input.contains('24'))
              date ='24';
            else if(input.contains('25'))
              date ='25';
            else if(input.contains('26'))
              date ='26';
            else if(input.contains('27'))
              date ='27';
            else if(input.contains('28'))
              date ='28';
            else if(input.contains('29'))
              date ='29';
            else if(input.contains('30'))
              date ='30';
            else if(input.contains('31'))
              date ='31';
              
                  
          
          // String date = input.substring(indexDate+10 , indexDate+20);
          String inputDate = '2023-$month-$date';
          data.add(inputDate);
        }

   

    if(input.contains('occassion'))
        {   String occassion = 'Birthday';
          
          int indexocc = input.indexOf('occassion');
          if(input.contains('Birthday'))
             occassion = 'Birthday';
          else if(input.contains('Anniversary'))
             occassion = 'Anniversary';
          else if(input.contains('Congratulations'))
             occassion = 'Congratulations';
          else 
             occassion = input.substring(indexocc+13);     
          // String number = input.substring(indexocc+10 , indexocc+20);

          data.add(occassion);
        
        }

    return data;
  }

  
}