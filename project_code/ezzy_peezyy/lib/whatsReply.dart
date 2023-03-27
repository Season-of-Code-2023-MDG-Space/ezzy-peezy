import 'package:flutter/services.dart';
import 'package:notification_reader/notification_reader.dart';
import 'package:spell_check_on_client/spell_check_on_client.dart';
import 'dart:math';
import 'wappCall.dart';

class whatsReply{

  whatsReply(){ initSpellCheck();}
  wappcall wc = wappcall();
  String didYouMean = '';
  SpellCheck spellCheck = SpellCheck.fromWordsList(['cat', 'bat', 'hat']);
  var commaIndex ;
  var colonIndex ;
  
  void keywordChecker(List<dynamic> data , var title)
  {   
      // print("Data = $data");
      Random random = new Random();
      int randomNumber = random.nextInt(5);
      int lenght = data.length;
       
      int number;
      List<String> thanksWays = ['Thank You','Thanks' , "Thank You So Much <3 " , 'Thanx' ];
      String text = data[lenght-1];
      int num =0;
      if(text.contains(':')){
      number = int.parse(text.substring(4,9)+ text.substring(10 , 15));
      text = text.substring( 17);
      }
      else{
        number = int.parse(title);
      }
      text = text.toLowerCase();
       didYouMean = spellCheck.didYouMean(text);
       if(didYouMean == ''){didYouMean = text; }
       print(didYouMean);
        print(number);
       if(didYouMean.contains('birthday') || didYouMean.contains('anniversary') || didYouMean.contains('congratulations') || didYouMean.contains('congrats'))
       {try{ wc.launchWhatsAppUri(number, thanksWays[randomNumber]) ;}
        catch(e){print("wrong no. $e");}
       }
       
      
  }
  void initSpellCheck() async {
    List<String> ss = ['en'];
    String content =
        await rootBundle.loadString('assets/en_words.txt');

    spellCheck = SpellCheck.fromWordsContent(content,
        letters: ss);
   
  }

  // void findIndex(String data)
  // {   
  //     for(int i=0 ; i<data.length ; i++ )
  //     {
  //       if(data[i] == ':')
  //       {
  //         colonIndex.add(i);
  //       }
  //       else if(data[i] == ',')
  //       {
  //         colonIndex.add(i);
  //       }
        
  //     }
  // }

}